//
//  CurrentRouteView.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class CurrentRouteView: UIView {
    
    //Image Views
    var logoImgView = UIImageView()
    
    //Text Fields
    var emailTF = UITextField()
    var passTF = UITextField()
    
    //Buttons
    var loginBtn = UIButton()
    var signUpBtn = UIButton()
    var forgotPassBtn = UIButton()
    
    func configureImageViews() {
        logoImgView.image = MWConstants.logoImg
        logoImgView.contentMode = .scaleAspectFit
    }
    
    func configureTextFields() {
        emailTF.placeholder = "Email"
        
        passTF.placeholder = "Pass"
    }
    
    func configureButtons() {
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.backgroundColor = UIColor.clear
        
        signUpBtn.setTitle("Sign Up", for: .normal)
        signUpBtn.setTitleColor(UIColor.white, for: .normal)
        signUpBtn.backgroundColor = UIColor.clear
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
            "psTF"  :   passTF,
            "login" :   loginBtn,
            "signup":   signUpBtn
        ] as [String : Any]
        
        self.prepareViewsForAutoLayout(viewsDict as! [String : UIView])
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-20-[logo]-20-[login]", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[logo]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
