//
//  SignUpView.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 2/24/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SwiftLoader

class SignUpView: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confPassword: UITextField!
    let ref = Firebase(url: "https://mealsonwheels.firebaseio.com/")
    var authorized = false
    
    @IBAction func signUp(sender: AnyObject) {
        if password.text == confPassword.text {            SwiftLoader.show(title: "Loading...", animated: true)
            ref.createUser(username.text, password: password.text, withCompletionBlock: { (error) -> Void in
                if (error != nil) {
                    let nameAlert = UIAlertController(title: "Failed Sign Up", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    nameAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(nameAlert, animated: true, completion: nil)
                } else {
                    self.authorized = true
                    self.ref.authUser(self.username.text, password: self.password.text) {
                        error, authData in
                        if error != nil {
                            // an error occured while attempting login
                        } else {
                            User.init(email: self.username.text!, password: self.password.text!, errorCase: {() -> Void in
                                SwiftLoader.hide()
                                let nameAlert = UIAlertController(title: "Failed Sign Up", message: "Incorrect Username or password", preferredStyle: UIAlertControllerStyle.Alert)
                                nameAlert
                                nameAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
                                self.presentViewController(nameAlert, animated: true, completion: nil)
                                self.authorized = false
                                }, closure: {() -> Void in
                                    SwiftLoader.hide()
                                    self.authorized = true
                                    self.performSegueWithIdentifier("signupcomplete", sender: self)
                            })
                        }
                    }
                }
           })
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "signupcomplete") {
            return authorized
        } else {
            return true
        }
    }
}
