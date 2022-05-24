//
//  LoginViewController.swift
//  BookFlights
//
//  Created by Khả Như on 5/11/22.
//  Copyright © 2022 hoangvu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElement()
    }
    func setUpElement() {
        // Hide error label
        errorLabel.alpha = 0
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                print("Login sucesfully userID: \(result!.user.uid)")
                self.transitionToHome()
            }
        }
    }
    func transitionToHome() {
        
        let homeVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeView) as? TabBarViewController
        
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
        
    }
}
