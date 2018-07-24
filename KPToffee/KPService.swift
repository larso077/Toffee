//
//  KPService.swift
//  KPToffee
//
//  Created by Erik Fisch on 6/5/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import Foundation
import Alamofire

public class KPService {
    public static let siteURLString: String = "http://kptoffee01.wisys.site"
    
    public static func getJSON(withURLString urlString: String, params: [String: String]?, completion: (([String: Any?]?, String?) -> Void)?) {
        Alamofire.request(
            URL(string: "\(siteURLString)\(urlString)")!,
            method: .get,
            parameters: params)
            .validate()
            .responseJSON { (response) -> Void in
                handleResponse(response: response, completion: completion)
        }
    }
    
    public static func postStuff(withURLString urlString: String, params: [String: String]?, completion: (([String: Any?]?, String?) -> Void)?) {
        Alamofire.request(
            URL(string: "\(siteURLString)\(urlString)")!,
            method: .post,
            parameters: params)
            .validate()
            .responseJSON { (response) -> Void in
                handleResponse(response: response, completion: completion)
        }
    }
    
    public static func upload(withURLString urlString: String, mediaData: Data?, requestParams: [String: Any], completion: (([[String: Any?]]?) -> Void)?) {
        let fullURL = "\(siteURLString)\(urlString)"
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let safeMediaData = mediaData {
                multipartFormData.append(safeMediaData, withName: "MediaContent")
            }
            
            for param in requestParams {
                multipartFormData.append(serialize(param.value)!, withName: param.key)
            }
        }, to: fullURL, method: .post) { (result) in
            switch result {
            case .success(_, _, _):
                if let safeCompletion = completion {
                    safeCompletion([["Result": "Success"]])
                }
                break
            case .failure(let encodingError):
                if let safeCompletion = completion {
                    safeCompletion([["Result": "Error", "Error": encodingError]])
                }
            }
        }
    }
    
    public static func getJSONList(withURLString urlString: String, params: [String: String]?, completion: (([[String: Any?]]?, String?) -> Void)?) {
        Alamofire.request(
            URL(string: "\(siteURLString)\(urlString)")!,
            method: .get,
            parameters: params)
            .validate()
            .responseJSON { (response) -> Void in
                if let safeCompletion = completion {
                    guard response.result.isSuccess else {
                        let errorString = String(describing: response.result.error)
                        
                        print("There was an error fetching the data: \(errorString)")
                        safeCompletion(nil, errorString)
                        return
                    }
                    
                    if let errorObject = response.result.value as? [String: Any?], let error = errorObject["Error"] as? [String: Any?], let errorMessage = error["Message"] as? String {
                        checkIfExpiredError(errorMessage: errorMessage)
                        safeCompletion(nil, errorMessage)
                        return
                    }
                    
                    guard let json = response.result.value as? [[String: Any?]] else {
                        print("the data is not valid")
                        safeCompletion(nil, "Invalid Server Response")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        safeCompletion(json, nil)
                    }
                }
        }
    }
    
    fileprivate static func serialize(_ value: Any) -> Data? {
        if JSONSerialization.isValidJSONObject(value) {
            return try? JSONSerialization.data(withJSONObject: value, options: [])
        } else {
            return String(describing: value).data(using: .utf8)
        }
    }
    
    fileprivate static func handleResponse(response: DataResponse<Any>, completion: (([String: Any?]?, String?) -> Void)?) {
        if let safeCompletion = completion {
            guard response.result.isSuccess else {
                let errorString = String(describing: response.result.error!)
                
                print("There was an error fetching the data: \(errorString)")
                safeCompletion(nil, errorString)
                return
            }
            
            guard let json = response.result.value as? [String: Any?] else {
                safeCompletion(nil, "Invalid Server Response")
                return
            }
            
            if let errorObject = json["Error"] as? [String: Any?], let errorText = errorObject["Message"] as? String {
                checkIfExpiredError(errorMessage: errorText)
                safeCompletion(nil, errorText)
            } else {
                DispatchQueue.main.async {
                    safeCompletion(json, nil)
                }
            }
        }
    }
    
    fileprivate static func checkIfExpiredError(errorMessage: String) {
        if errorMessage == "Token Invalid or Expired!" {
            KPAuthentication.shared.logout()
        }
    }
}









