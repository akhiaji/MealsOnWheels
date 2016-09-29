//
//  RegistrationController.swift
//  MealsOnWheels
//
//  Created by Taabish Kathawala on 9/29/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//


import Foundation
import UIKit
import SwiftLoader

class RegistrationController : UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var passConfirmField: UITextField!
    @IBOutlet weak var next: UIButton!
    var passConfirm = false
    var registrationView = RegistrationView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        
    }
    
    func configureView() {
        configureButtons()
        self.view = RegistrationView
    }
    
    
    override func viewDidLoad() {
        configureView()

    }
    
    @IBAction func confirmPasswords(sender: AnyObject) {
        SwiftLoader.show(title: "Loading...", animated: true)
        if passField.text.isEmpty || passConfirmField.text.isEmpty {
            passConfirm = false
            SwiftLoader.hide()
            let emptyFields = UIAlertController(title: "Failed Sign Up", message: "Please Enter in a Password and Confirm", preferredStyle: UIAlertController.alert)
            emptyFields
            emptyFields.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel, handler: nil))
        }
        
        if passField.text != passConfirmField.text {
            passConfirm = false
            SwiftLoader.hide()
            let wrongConfirm = UIAlertController(title: "Failed Sign Up", message: "Your Password Does Not Match Confirm Password", preferredStyle: UIAlertControllerStyle.alert)
            wrongConfirm
            wrongConfirm.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel, handler: nil))
            self.passConfirm = false
        }
        
        if passField.text == passConfirmField.text {
            SwiftLoader.hide()
            self.passConfirm = true
            
        }
    }
    
}



