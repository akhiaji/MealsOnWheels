//
//  LoginConroller.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 2/17/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import SwiftLoader
import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    var loginSuccess = false
    var loginView = LoginView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        
    }
    
    func configureView() {
        
        configureButtons()
        
        self.view = loginView
        
    }
    
    override func viewDidLoad() {
        let prefs = NSUserDefaults.standardUserDefaults()
        if (prefs.valueForKey("email") != nil && prefs.valueForKey("pass") != nil) {
            User.init(email: prefs.valueForKey("email") as! String, password: prefs.valueForKey("pass")as! String, errorCase: {() -> Void in
                }, closure: {() -> Void in
                    self.performSegueWithIdentifier("login", sender: self)
            })
        }

    }
    
    @IBAction func signIn(sender: AnyObject) {
        SwiftLoader.show(title: "Loading...", animated: true)
        User.init(email: emailField.text!, password: passField.text!, errorCase: {() -> Void in
            SwiftLoader.hide()
            let nameAlert = UIAlertController(title: "Failed Sign Up", message: "Incorrect Username or password", preferredStyle: UIAlertControllerStyle.Alert)
            nameAlert
            nameAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(nameAlert, animated: true, completion: nil)
            self.loginSuccess = false
        }, closure: {() -> Void in
            SwiftLoader.hide()
            self.loginSuccess = true
            self.performSegueWithIdentifier("login", sender: self)
        })
    
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "login") {
            return loginSuccess
        } else {
            return true
        }
    }
}