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
        logoImgView.contentMode = .scaleAspectFit
    }
    
    func configureTextFields() {
        emailTF.placeholder = "Email"
        
        passwordTF.placeholder = "Password"
    }
    
    func configureButtons() {
        loginBtn.setTitle("Login", for: UIControlState())
        loginBtn.setTitleColor(UIColor.blue, for: UIControlState())
        loginBtn.backgroundColor = UIColor.white
        
        signUpBtn.setTitle("Sign Up", for: UIControlState())
        signUpBtn.setTitleColor(UIColor.blue, for: UIControlState())
        signUpBtn.backgroundColor = UIColor.white
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
        ] as [String : Any]
        
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
