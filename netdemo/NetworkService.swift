//
//  NetworkService.swift
//
//  Created by ms on 5/18/17.
//  Copyright © 2017 ms. All rights reserved.
//

import UIKit

class NetworkService: NSObject {
    
    static let URL_BASE: String = "http://192.168.2.105:8080"
    
    static func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
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
    
    static func getSessionConfiguration(_ account: Account) -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        let userPasswordString = "\(account.username):\(account.getPassword())"
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
      //  let base64EncodedCredential = userPasswordData!.base64EncodedString()
        let jwtToken = ""
        config.httpAdditionalHeaders = ["Authorization": "Bearer \(jwtToken)"]
        return config
    }
    
    static func getURL(_ uri: String) -> URL {
        return URL(string: "\(NetworkService.URL_BASE)\(uri)")!
    }
    
    static func makeFormEncodedRequestFrom(_ uri: String) -> URLRequest {
        let url = NetworkService.getURL(uri)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        return request
    }
    
    static func makeGetRequestFrom(_ uri: String) -> URLRequest {
        let url = NetworkService.getURL(uri)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
}
