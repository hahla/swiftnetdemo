//
//  NetworkService.swift
//
//  Created by ms on 5/18/17.
//  Copyright © 2017 ms. All rights reserved.
//

import UIKit

class NetworkService: NSObject {
    
    static let URL_BASE: String = "http://localhost:8080"
    
    static func createStringFromDictionary(_ dict: Dictionary<String, Any>) -> String {
        var params = String()
        for (key, value) in dict {
            let strValue = String(describing: value)
            params += "\(key)=\(strValue.addingPercentEncodingForFormUrlencoded())&"
        }
        // remove final &
        let trimmedStr = params.trimmingCharacters(in: CharacterSet(charactersIn: "&"))
        return trimmedStr
    }

    static func createDataFromDictionary(_ dict: Dictionary<String, Any>) -> Data? {
        return createStringFromDictionary(dict).data(using: .utf8)
    }
    
    static func createJsonFromDictionary(_ dict:  Dictionary<String, Any>) -> Data {
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict,
                                                      options: [.prettyPrinted]) {
            return jsonData
        }
        return "failed to createJsonFromDictionary".data(using: .utf8)!
    }
    
    // These functions are for use after login has been completed
    // and a jwt is available
    static func getSessionConfiguration(_ jwt: String) -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization": "Bearer \(jwt)"]
        print("additionalHeaders = \(String(describing: config.httpAdditionalHeaders))")
        return config
    }
    
    static func getURL(_ uri: String) -> URL {
        return URL(string: "\(NetworkService.URL_BASE)\(uri)")!
    }

    // These functions do not require a jwt token
    static func makeJsonPostRequest(_ uri: String) -> URLRequest {
        let url = NetworkService.getURL(uri)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        return request
    }
    
}
