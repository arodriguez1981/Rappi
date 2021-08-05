//
//  NetConnection.swift
//  Rappi iOS Test
//
//  Created by Alex Rodriguez on 04/08/21.
//  Copyright © 2021 Alex Rodriguez. All rights reserved.
//
import Foundation
import Alamofire
import AFNetworking


let WS_TMDB4 = "https://api.themoviedb.org/4/"
let WS_TMDB3 = "https://api.themoviedb.org/3/"

typealias JSON_RESPONSE = (_ completionHanlder: DataResponse<Any>) -> ()
typealias ENCODING_COMPLETED = (_ encodingResult: SessionManager.MultipartFormDataEncodingResult) -> ()

class NetConnection: NSObject {
    
    
    fileprivate static var staticManager: SessionManager?
    static var manager: SessionManager {
        if staticManager != nil {
            return staticManager!
        }
        let configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        staticManager = Alamofire.SessionManager(
            configuration: configuration
        )
        return staticManager!
    }
    
    // MARK: - FOR API v4
    
    
    class func createRequestToken(_ params:[String: AnyObject], response: ResponseHandler) {
        response.startHandler?()
        manager.request(WS_TMDB4 + "auth/request_token", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
            .responseJSON(completionHandler: response.responseHandler)
    }
    
    class func createAccessToken(_ params:[String: AnyObject], response: ResponseHandler) {
        response.startHandler?()
        manager.request(WS_TMDB4 + "auth/access_token", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
            .responseJSON(completionHandler: response.responseHandler)
    }
    
    class func getMedia(_ page: Int, type: String, movie: Bool,  response: ResponseHandler) {
        response.startHandler?()
        let currentType = type.lowercased()
        var currentMovie = ""
        if movie{
            currentMovie = "movie"
        }
        else{
            currentMovie = "tv"
        }
        manager.request(WS_TMDB3 + "\(currentMovie)/\(currentType)?api_key=\(APIKey)&language=en-US&page=\(page)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            
            .responseJSON(completionHandler: response.responseHandler)
    }
    
    class func getMovieDetails(_ movieId: Int, response: ResponseHandler) {
        response.startHandler?()
        manager.request(WS_TMDB3 + "movie/\(movieId)?api_key=\(APIKey)&language=en-US", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            
            .responseJSON(completionHandler: response.responseHandler)
    }
    
    class func getEpisodeDetails(_ episodeId: Int, response: ResponseHandler) {
        response.startHandler?()
        manager.request(WS_TMDB3 + "tv/\(episodeId)?api_key=\(APIKey)&language=en-US", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            
            .responseJSON(completionHandler: response.responseHandler)
    }
    
    class func getVideos(_ movieId: Int, response: ResponseHandler) {
        response.startHandler?()
        manager.request(WS_TMDB3 + "movie/\(movieId)/videos?api_key=\(APIKey)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            
            .responseJSON(completionHandler: response.responseHandler)
    }
    
    class func getEpisodeVideos(_ episodeId: Int, response: ResponseHandler) {
        response.startHandler?()
        manager.request(WS_TMDB3 + "tv/\(episodeId)/videos?api_key=\(APIKey)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            
            .responseJSON(completionHandler: response.responseHandler)
    }

}


