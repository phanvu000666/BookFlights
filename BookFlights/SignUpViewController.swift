//
//  SignUpViewController.swift
//  BookFlights
//
//  Created by Khả Như on 5/11/22.
//  Copyright © 2022 hoangvu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElement()
    }
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func setUpElement() {
        // Hide error label
        errorLabel.alpha = 0
    }
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 6 characters, contains a special character and a number."
        }
        
        return nil
    }
        
    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("The email address is badly formatted.")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                     // Add a new document with a generated ID
                    var ref: DocumentReference? = nil
                    ref = db.collection("users").addDocument(data: [
                        "first_name":firstName,
                        "last_name":lastName,
                        "email":authResult!.user.email,
                        "sdt": authResult!.user.phoneNumber,
                        "uid": authResult!.user.uid
                    ]) { err in
                        if let err = err {
                            print("Error adding user: \(err)")
                        } else {
                            print("User added with ID: \(ref!.documentID)")
                        }
                    }
//                    db.collection("users").addDocument(data: ["first_name":firstName, "last_name":lastName, "uid": authResult!.user.uid ]) { (error) in
//                        if error != nil {
//                            // Show error message
//                            self.showError("Error saving user data")
//                        }
//                    }
                    // Transition to the home screen
                    self.transitionToLogin()
                }
                
            }
            
        }
        
    }
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToLogin() {
        
        let loginVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginView) as? LoginViewController
        
        view.window?.rootViewController = loginVC
        view.window?.makeKeyAndVisible()
        
    }
}
