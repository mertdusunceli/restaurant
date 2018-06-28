//
//  LoginViewController.swift
//  Restaurant
//
//  Created by Mert Dusunceli on 5/30/18.
//  Copyright © 2018 Mert Dusunceli. All rights reserved.
//

import UIKit
import FirebaseAuth

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
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                if signupMode {
                    //Sign Up
                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                        if let error = error {
                            self.presentAlert(alert: error.localizedDescription)
                        } else {
                            print("Sign up was successful")
                            self.performSegue(withIdentifier: "moveToFood", sender: nil)
                        }
                    }
                    
                } else {
                    //Login
                    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                        if let error = error {
                            self.presentAlert(alert: error.localizedDescription)
                        } else {
                            print("Log in was successful")
                            self.performSegue(withIdentifier: "moveToFood", sender: nil)
                        }
                    }
                }
            }
        }
    }
    
    func presentAlert(alert: String) {
        let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
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

