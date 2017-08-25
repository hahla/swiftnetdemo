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
        self.id = json["createdAt"].intValue
        self.password = json["password"].stringValue
    }
    
    var id: Int
    var username: String
    private var password: String?
    
    func getPassword() -> String {
        return self.password!
    }

    /**
     * Auth to server and generate a User object if successful using success/fail closures
     */
    static func doLogin(username: String,
                        _ password: String,
                        success: @escaping(_ user: Account) -> Void,
                        fail: @escaping(_ error: String) -> Void) -> URLSessionDataTask
    {
        var request = NetworkService.makeFormEncodedRequestFrom(postLoginAPI)
        request.httpBody = NetworkService.createDataFromDictionary(["username": username, "password": password])

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            do {
                let httpResponse = response as! HTTPURLResponse
                let jsonBody = try JSON(data: data!) as JSON
                if httpResponse.statusCode == 200 {
                    return success(Account(jsonBody["data"]))
                }
                fail(jsonBody["message"].stringValue)
            } catch let error as NSError {
                print("doLogin failed:", error.localizedDescription)
                fail(error.localizedDescription)
            }
        })
        return task
    }
}
