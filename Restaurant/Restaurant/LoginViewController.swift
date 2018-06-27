//
//  LoginViewController.swift
//  Restaurant
//
//  Created by Mert Dusunceli on 5/30/18.
//  Copyright © 2018 Mert Dusunceli. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var signupMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func topTapped(_ sender: Any) {
    }
    
    @IBAction func bottomTapped(_ sender: Any) {
        if signupMode {
            //Switch to log in
            signupMode = false
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
            
        } else {
            //Switch to sign up
            signupMode = true
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)
        }
        
    }
    
}

