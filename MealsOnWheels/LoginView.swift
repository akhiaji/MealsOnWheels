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
    //
    
    
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
        emailTF.layer.cornerRadius = 10.0
        emailTF.layer.borderWidth = 1
        emailTF.textColor = UIColor.white
        
        
        
        passwordTF.placeholder = "Password"
        passwordTF.layer.cornerRadius = 10.0
        passwordTF.layer.borderWidth = 1
        passwordTF.textColor = UIColor.white

    }
    
    func configureButtons() {
        loginBtn.setTitle("Login", for: UIControlState())
        loginBtn.setTitleColor(UIColor.blue, for: UIControlState())
        loginBtn.backgroundColor = UIColor.white
        loginBtn.layer.cornerRadius = 20.0
        loginBtn.layer.borderColor = UIColor.white.cgColor
        loginBtn.layer.borderWidth = 1

        
        signUpBtn.setTitle("Sign Up", for: UIControlState())
        signUpBtn.setTitleColor(UIColor.blue, for: UIControlState())
        signUpBtn.backgroundColor = UIColor.white
        
    }
    
    func configureView() {
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [MWConstants.colors.loginDarkGradient.cgColor, MWConstants.colors.loginLightGradient.cgColor]
        self.layer.insertSublayer(gradient, at: 0)

//        self.backgroundColor = MWConstants.colors.loginBackground
        
        //configureImageViews()
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
        
        self.prepareViewsForAutoLayout(viewsDict as! [String : UIView])
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-50-[emTF]-30-[psTF]-100-[login]-30-[signup]", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[emTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[psTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[login]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[signup]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        

        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
