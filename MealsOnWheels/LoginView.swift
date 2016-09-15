//
//  LoginView.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    //Image Views
    var logoImgView = UIImageView()
    
    //Text Fields
    var emailTF = UITextField()
    var passwordTF = UITextField()
    
    //Buttons
    var loginBtn = UIButton()
    var signUpBtn = UIButton()
    var forgotPasswordBtn = UIButton()
    
    func configureImageViews() {
        logoImgView.image = MWConstants.logoImg
        logoImgView.contentMode = .ScaleAspectFit
    }
    
    func configureTextFields() {
        emailTF.placeholder = "Email"
        
        passwordTF.placeholder = "Password"
    }
    
    func configureButtons() {
        loginBtn.setTitle("Login", forState: .Normal)
        loginBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        loginBtn.backgroundColor = UIColor.whiteColor()
        
        signUpBtn.setTitle("Sign Up", forState: .Normal)
        signUpBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        signUpBtn.backgroundColor = UIColor.whiteColor()
    }
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.loginBackground
        
        configureImageViews()
        configureTextFields()
        configureButtons()
        
        //Auto Layout
        let viewsDict = [
            "logo"  :   logoImgView,
            "emTF"  :   emailTF,
            "psTF"  :   passwordTF,
            "login" :   loginBtn,
            "signup":   signUpBtn
        ]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-20-[logo]-20-[login]-20-[signup]", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(MWConstants.loginFieldsOffset))-[logo]-\(String(MWConstants.loginFieldsOffset))-|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(MWConstants.loginFieldsOffset))-[login(==100)]-\(String(MWConstants.loginFieldsOffset))-|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(MWConstants.loginFieldsOffset))-[signup]-\(String(MWConstants.loginFieldsOffset))-|", views: viewsDict))
        

        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}