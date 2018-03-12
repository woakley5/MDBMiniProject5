//
//  FirebaseAuthHelper.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import Foundation
import FirebaseAuth
import PromiseKit

class FirebaseAuthHelper {
    
    static func logIn(email: String, password: String, view: UIViewController, withBlock: @escaping (User?)->()) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user: User?, error) in
            if error == nil {
                withBlock(user)
            }
            else{
                beaverLog.error(error.debugDescription)
                showAlert(title: "Log In Error", message: "Looks like that user doesnt exist or you entered a wrong password!", currentView: view)
            }
        })
    }
    
    static func signUp(name: String, username: String, email: String, password: String, image: UIImage, view: UIViewController, withBlock: @escaping (User) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: User?, error) in
            if error == nil {
                FirebaseDatabaseHelper.createNewUser(name: name, username: username, email: email, image: image, successBlock: {
                    beaverLog.info("User created!")
                    withBlock(user!)
                })
            }
            else {
                print(error.debugDescription)
                showAlert(title: "Sign Up Error", message: "Sorry there was an error creating your account. Try again later.", currentView: view)
            }
        })
        
    }
    
    static func logOut(view: UIViewController) -> Promise<Bool> {
        return Promise { fulfill, _ in
            let auth = Auth.auth()
            do {
                try auth.signOut()
                fulfill(true)
            } catch let signOutError as NSError {
                beaverLog.error("Error signing out: \(signOutError.debugDescription)")
                showAlert(title: "Error Logging Out", message: signOutError.debugDescription, currentView: view)
            }
        }
    }
    
    static func isLoggedIn() -> Bool {
        if Auth.auth().currentUser != nil{
            beaverLog.info("Logged in")
            return true
        }
        else {
            beaverLog.info("Not Logged In")
            return false
        }
    }
    
    static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    static private func showAlert(title: String, message: String, currentView: UIViewController) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        currentView.present(alertController, animated: true, completion: nil)
    }
}
