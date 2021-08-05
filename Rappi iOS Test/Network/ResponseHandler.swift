//
//  ResponseHandler.swift
//  Rappi iOS Test
//
//  Created by Alex Rodriguez on 04/08/21.
//  Copyright © 2021 Alex Rodriguez. All rights reserved.
//

import Foundation
import UIKit

public typealias JSON = [String: Any]
typealias REQUEST_START = () -> ()
typealias RESPONSE_SUCCESS = (_ json: JSON) -> Array<IndexPath>?
typealias RESPONSE_FAILURE = (_ error: NSError, _ data: Data?) -> ()

class ResponseHandler {
    
    var responseHandler: JSON_RESPONSE!
    var multiPartResponseHandler: ENCODING_COMPLETED!
    var startHandler: REQUEST_START?
    var successHandler: RESPONSE_SUCCESS!
    var failureHandler: RESPONSE_FAILURE?
    
    init(startHandler: REQUEST_START?, success: @escaping RESPONSE_SUCCESS, failure: RESPONSE_FAILURE?) {
        self.startHandler = startHandler
        self.successHandler = success
        self.failureHandler = failure
        
        responseHandler = {
            response in
            switch response.result {
            case .success(_):
                let json = response.result.value! as! JSON
                if json["status_code"] != nil && (json["status_code"] as? Int == 7 || json["status_code"] as? Int == 34){
                    let alert = UIAlertController(title: "Error", message: json["status_message"] as? String, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                    AppDelegate.getTopMostViewController()?.present(alert, animated: true, completion: nil)
                }
                self.onSuccess(response.result.value!)
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                AppDelegate.getTopMostViewController()?.present(alert, animated: true, completion: nil)
                self.onFailure(error as NSError, data: response.data)
            }
        }
        
        multiPartResponseHandler = {
            encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.validate().responseJSON(completionHandler: self.responseHandler)
            case .failure(let encodingError):
                print("Failure encoding")
                self.onFailure(encodingError as NSError, data: nil)
            }
        }
    }
    

    func onSuccess(_ value: Any) {
        _ = successHandler(value as! JSON)
    }
    
    func onFailure(_ error: NSError, data: Data?) {
        failureHandler?(error, data)
    }
    
}



