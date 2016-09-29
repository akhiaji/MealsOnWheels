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
    var ref = FIRDatabase.database().reference()
    var authorized = false
    
    @IBAction func signUp(_ sender: AnyObject) {
        if password.text == confPassword.text {            SwiftLoader.show(title: "Loading...", animated: true)
            FIRAuth.auth()!.createUser(withEmail: username.text!, password: password.text!, completion: { (user, error) -> Void in
                if (error != nil) {
                    let nameAlert = UIAlertController(title: "Failed Sign Up", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    nameAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(nameAlert, animated: true, completion: nil)
                } else {
                    self.authorized = true
                    FIRAuth.auth()?.signIn(withEmail: self.username.text!, password: self.password.text!) {
                        error, authData in
                        if error != nil {
                            // an error occured while attempting login
                        } else {
                            User.init(email: self.username.text!, password: self.password.text!, errorCase: {() -> Void in
                                SwiftLoader.hide()
                                let nameAlert = UIAlertController(title: "Failed Sign Up", message: "Incorrect Username or password", preferredStyle: UIAlertControllerStyle.alert)
                                nameAlert
                                nameAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                                self.present(nameAlert, animated: true, completion: nil)
                                self.authorized = false
                                }, closure: {() -> Void in
                                    SwiftLoader.hide()
                                    self.authorized = true
                                    self.performSegue(withIdentifier: "signupcomplete", sender: self)
                            })
                        }
                    }
                }
           })
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "signupcomplete") {
            return authorized
        } else {
            return true
        }
    }
}
