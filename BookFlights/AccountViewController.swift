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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    func transitionToStart() {
        
        let startVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.startView) as? StartViewController
        
        view.window?.rootViewController = startVC
        view.window?.makeKeyAndVisible()
        
    }

}
