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
        doLogin(username: "admin2", "abc123")
    }

    @IBAction func doLoginFail(_ sender: Any) {
        doLogin(username: "adminBAD", "abc123")
    }
    
    
    func doLogin(username: String, _ password: String)  {
        
        func success (_ account: Account) {
            DispatchQueue.main.async(){
                print("success!", account)
                // do stuff, like execute segues
            }
        }
        
        func fail(_ error: String) {
            DispatchQueue.main.async(){
                print("error!", error)
            }
        }

        // synchronize ui updates here with network request starting
        Account.doLogin(username: username, password, success: success, fail: fail).resume()
    }
}

