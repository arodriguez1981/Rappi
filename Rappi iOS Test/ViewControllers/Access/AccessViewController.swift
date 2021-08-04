//
//  AccessViewController.swift
//  Rappi iOS Test
//
//  Created by Alex Rodriguez on 04/08/21.
//  Copyright © 2021 Alex Rodriguez. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class AccessViewController: UIViewController, closeWebViewDelegate {
    var workItem: DispatchWorkItem?
    @IBOutlet var btnAccess: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func requestAccess(_ sender: Any) {
        var params = [String: AnyObject]()
        headers = [
            "Authorization": "Bearer " + (accessToken),
            "Accept": "application/json;charset=utf-8"
        ]
        params["redirect_to"] = "http://www.themoviedb.org/" as AnyObject
        NetConnection.createRequestToken(params, response: ResponseHandler(startHandler: nil , success: { response in
            DispatchQueue.main.async(execute: {() -> Void in
                if response["status_code"] as! Int != 1{

                }
                else{
                    let requestToken = response["request_token"] as! String
                    self.createAccessToken(requestToken)
                }
            })
            return nil
        } , failure: {(_ error: NSError, data: Data?) in
            DispatchQueue.main.async(execute: {() -> Void in

            })
        }))
    }
    
    func createAccessToken(_ requestToken : String){
        var params = [String: AnyObject]()
        params["request_token"] = requestToken as AnyObject
        
        workItem = DispatchWorkItem{
            NetConnection.createAccessToken(params, response: ResponseHandler(startHandler: nil , success: { response in
                realm = try? Realm()
                if response["status_code"] as! Int == 41{
                    self.goToWebView(requestToken)
                }
                else{
                    accountId = response["account_id"] as! String
                    currentAccessToken = response["access_token"] as! String
                    
                    let vc = CategoryViewController.instantiate(fromAppStoryboard: .Category)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                return nil
            } , failure: {(_ error: NSError, data: Data?) in
                if #available(iOS 10.0, *) {
//                    showSimpleErrorSnackBar(try! AppDelegate.getMessageFromError(error: error), onFinish: {() -> Void in
//
//                    })
                } else {
                    // Fallback on earlier versions
                }
            }))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() , execute: workItem!)
    }
    
    func goToWebView(_ requestToken: String){
        let vc = WKWebViewController.instantiate(fromAppStoryboard: .WKWebView)
        vc.titulo = "Approve request token"
        vc.requestToken = requestToken
        vc.closeDelegate = self as closeWebViewDelegate
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    func close(_ requestToken: String) {
        self.workItem?.cancel()
        self.createAccessToken(requestToken)
    }
}
