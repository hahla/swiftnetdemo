//
//  Account.swift
//
//  Created by ms on 8/24/17
//  Copyright © 2017 ms. All rights reserved.
//

import UIKit


let postLoginAPI  = "/login"
let testAPI = "/account/test"

class Account: NSObject {
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.username = json["username"].stringValue
        self.createdAt = json["createdAt"].intValue
        self.password = json["password"].stringValue
    }
    
    var id: Int
    var username: String
    var createdAt: Int
    private var password: String?
    
    func getPassword() -> String {
        return self.password!
    }

    /**
     * Auth to server and generate a User object if successful using success/fail closures
     */
    static func doLogin(username: String,
                        _ password: String,
                        success: @escaping(_ jwt: String) -> Void,
                        fail: @escaping(_ error: String) -> Void) -> URLSessionDataTask
    {
        var request = NetworkService.makeJsonPostRequest(postLoginAPI)
        request.httpBody = NetworkService.createJsonFromDictionary(
            ["username": username, "password": password])

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            do {
                let httpResponse = response as! HTTPURLResponse
                let authStr = httpResponse.allHeaderFields["Authorization"] as! String
                let authSplit = authStr.components(separatedBy: " ")

                if httpResponse.statusCode == 200 &&
                    authSplit.count == 2 {
                    return success(authSplit[1])
                } else {
                    fail("invalid auth: [\(authStr)]")
                }
            }
        })
        return task
    }
    
    static func doGetAccountPostLogin(
        jwt: String,
        success: @escaping(_ account: Account) -> Void,
        fail: @escaping(_ error: String) -> Void) -> URLSessionDataTask
    {
        let request = NetworkService.makeJsonPostRequest(testAPI)

        let session = URLSession(configuration: NetworkService.getSessionConfiguration(jwt))
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            do {
                let httpResponse = response as! HTTPURLResponse
                if httpResponse.statusCode == 200 {
                    let jsonBody = try JSON(data: data!) as JSON
                    print("json", jsonBody)
                    if httpResponse.statusCode == 200 {
                        return success(Account(jsonBody))
                    }
                    fail(jsonBody["message"].stringValue)
                }
            } catch let error as NSError {
                print("doLogin failed:", error.localizedDescription)
                fail(error.localizedDescription)
    
            }
        })
        return task
    }
}
