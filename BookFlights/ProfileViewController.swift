//
//  ProfileViewController.swift
//  BookFlights
//
//  Created by Khả Như on 14/05/2022.
//  Copyright © 2022 . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElement()
        checkIfUserIsSignedIn()
    }
    
    func setUpElement() {
        // Hide error label
        errorLabel.alpha = 0
    }
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        return nil
    }
    @IBAction func editTapped(_ sender: Any) {
        
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            if let user = user {
              // The user's ID, unique to the Firebase project.
              // Do NOT use this value to authenticate with your backend server,
              // if you have one. Use getTokenWithCompletion:completion: instead.
              let uid = user.uid
                
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
                    let sdt = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    // Edit profile
                    let docData: [String: Any] = [
                        "first_name":firstName,
                        "last_name":lastName,
                        "email":email,
                        "sdt":sdt
                    ]
                    let db = Firestore.firestore()
                    db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { (result, error) in
                        if error == nil{
                            for document in result!.documents{
                                document.reference.updateData(docData)
                                self.showError("Update sucesfully!")
                            }
                        } else if uid == nil {
                            self.showError("No user is signed in..")
                        } else {
                            self.showError("Fails")
                        }
                    }
                    
                }
              // ...
            }
        }
    }
    private func checkIfUserIsSignedIn() {

        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                let sdt = user.phoneNumber
                print("UserID: \(uid)")
                // ...
                let db = Firestore.firestore()
                db.collection("users").whereField("uid", isEqualTo: uid)
                    .addSnapshotListener { querySnapshot, error in
                        guard let documents = querySnapshot?.documents else {
                            print("Error fetching documents: \(error!)")
                            return
                        }
                        let lastName = documents.map { $0["last_name"]! }
                        let firstName = documents.map { $0["first_name"]! }
                        let email = documents.map { $0["email"]! }
                        let sdt = documents.map { $0["sdt"]! }
                        
                        self.lastNameTextField.text = "\(lastName)"
                        self.firstNameTextField.text = "\(firstName)"
                        self.emailTextField.text = "\(email)"
                        self.phoneNumberTextField.text = "\(sdt)"
                        
                        // print data
                        print("data: \(lastName)")
                        print("data: \(firstName)")
                        print("data: \(email)")
                        print("data: \(sdt)")
                    }
//                db.collection("users").whereField("uid", isEqualTo: uid)
//                    .getDocuments() { (querySnapshot, err) in
//                        if let err = err {
//                            print("Error getting documents: \(err)")
//                        } else {
//                            for document in querySnapshot!.documents {
//                                print("\(document.documentID) => \(document.data())")
////                                emailTextField.text = ((document.documentID) -> document.data())
//                            }
//                        }
//                }
//                emailTextField.text = sdt
//                lastNameTextField.text =
            }
        } else {
          // No user is signed in.
            self.showError("No user is signed in.")
          // ...
        }
    }
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
