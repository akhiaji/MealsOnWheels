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

class SignUpView: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confPassword: UITextField!
    let ref = Firebase(url: "https://mealsonwheels.firebaseio.com/")
    var authorized = false
    
    @IBAction func signUp(sender: AnyObject) {
        if password.text == confPassword.text {
            ref.createUser(username.text, password: password.text, withCompletionBlock: { (NSError error) -> Void in
                if (error != nil) {
                    let nameAlert = UIAlertController(title: "Failed Sign Up", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    nameAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(nameAlert, animated: true, completion: nil)
                } else {
                    self.authorized = true
                    self.ref.authUser(self.username.text, password: self.password.text, withCompletionBlock: nil)
                    self.performSegueWithIdentifier("signupcomplete", sender: self)
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
