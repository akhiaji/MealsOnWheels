//
//  LoginConroller.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 2/17/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit
import SwiftLoader

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
        
//        
//        let gradient = CAGradientLayer()
//        gradient.frame = self.view.bounds
//        gradient.colors = [MWConstants.colors.loginDarkGradient.cgColor, MWConstants.colors.loginLightGradient.cgColor]
//        self.view.layer.insertSublayer(gradient, at: 0)

        configureButtons()
        self.view.addSubview(loginView)
        
    }
    
    override func viewDidLoad() {
//        let prefs = UserDefaults.standard
//        if (prefs.value(forKey: "email") != nil && prefs.value(forKey: "pass") != nil) {
//            User.init(email: prefs.value(forKey: "email") as! String, password: prefs.value(forKey: "pass")as! String, errorCase: {() -> Void in
//                }, closure: {() -> Void in
//                    self.performSegue(withIdentifier: "login", sender: self)
//            })
//        }
        configureView()
    }
    
    @IBAction func signIn(_ sender: AnyObject) {
//        SwiftLoader.show(title: "Loading...", animated: true)
//        User.init(email: emailField.text!, password: passField.text!, errorCase: {() -> Void in
//            SwiftLoader.hide()
//            let nameAlert = UIAlertController(title: "Failed Sign Up", message: "Incorrect Username or password", preferredStyle: UIAlertControllerStyle.alert)
//            nameAlert
//            nameAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
//            self.present(nameAlert, animated: true, completion: nil)
//            self.loginSuccess = false
//        }, closure: {() -> Void in
//            SwiftLoader.hide()
//            self.loginSuccess = true
//            self.performSegue(withIdentifier: "login", sender: self)
//        })
//    
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "login") {
            return loginSuccess
        } else {
            return true
        }
    }
}
