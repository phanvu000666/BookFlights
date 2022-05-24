//
//  AccountViewController.swift
//  BookFlights
//
//  Created by Khả Như on 14/05/2022.
//  Copyright © 2022 hoangvu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class AccountViewController: UIViewController {
    @IBOutlet weak var accountNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsSignedIn()
        // Do any additional setup after loading the view.
    }
    @IBAction func logoutTapped(_ sender: Any) {
        logoutUser()
    }
    func logoutUser() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print ("Logout suscesfully ...")
            transitionToStart()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    private func checkIfUserIsSignedIn() {

        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
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
                        
                        self.accountNameLabel.text = "\(firstName)"
                        
                        print("data: \(lastName)")
                        print("data: \(firstName)")
                    }
            }
        } else {
          // No user is signed in.
            print("No user is signed in.")
          // ...
        }
    }
    func transitionToStart() {
        
        let startVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.startView) as? StartViewController
        
        view.window?.rootViewController = startVC
        view.window?.makeKeyAndVisible()
        
    }

}
