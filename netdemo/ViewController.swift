//
//  ViewController.swift
//  netdemo
//
//  Created by ms on 8/25/17.
//  Copyright © 2017 ms. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doLoginSuccess(_ sender: Any) {
        doLogin(username: "admin", "secret")
    }

    @IBAction func doLoginFail(_ sender: Any) {
        doLogin(username: "adminBAD", "wrong")
    }
    
    
    // Initiate Login, and if successful, then
    func doLogin(username: String, _ password: String)  {
        
        func success (_ jwt: String) {
            func gotAccountSuccess(_ account: Account) {
                DispatchQueue.main.async(){
                    print("successfully got account!", account)
                    // do stuff, like execute segues
                }
            }
            print("successfully got jwt!", jwt)
            Account.doGetAccountPostLogin(jwt: jwt,
                                          success: gotAccountSuccess,
                                          fail: fail).resume()
        }
        
        func fail(_ error: String) {
            DispatchQueue.main.async(){
                print("error!", error)
            }
        }

        // synchronize ui updates here with network request starting
        Account.doLogin(username: username,                        password, success: success, fail: fail).resume()
    }
}

