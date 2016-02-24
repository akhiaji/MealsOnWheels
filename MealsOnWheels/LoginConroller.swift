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
    
    override func viewDidLoad() {
        let prefs = NSUserDefaults.standardUserDefaults()
        if (prefs.valueForKey("email") != nil && prefs.valueForKey("pass") != nil) {
            User.init(email: prefs.valueForKey("email") as! String, password: prefs.valueForKey("pass")as! String, errorCase: {() -> Void in
                }, closure: {() -> Void in
                    self.performSegueWithIdentifier("login", sender: self)})
        }

    }
    
    @IBAction func signIn(sender: AnyObject) {
        SwiftLoader.show(title: "Loading...", animated: true)
        User.init(email: emailField.text!, password: passField.text!, errorCase: {() -> Void in
            SwiftLoader.hide()
        }, closure: {() -> Void in
                SwiftLoader.hide()
                self.performSegueWithIdentifier("login", sender: self)
                print("Hello segue")
        })
        
    }
}