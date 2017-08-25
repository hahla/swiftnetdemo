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
        doLogin(email: "emailok@pingzee.com", "abc123")
    }

    @IBAction func doLoginFail(_ sender: Any) {
        doLogin(email: "emailok@pingzee.com", "abc123")
    }
    
    
    func doLogin(email: String, _ password: String)  {
        
        func success (_ user: User) {
            DispatchQueue.main.async(){
                print("success!", user)
                // do stuff, like execute segues
            }
        }
        
        func fail(_ error: String) {
            DispatchQueue.main.async(){
                print("error!", error)
            }
        }

        // synchronize ui updates here with network request starting
        User.doLogin(email: email, password, success: success, fail: fail).resume()
    }
}

