//
//  TitleViewButtonHub.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 9/29/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class TitleViewButtonHub: UIView {
    
    //Buttons
    var signUpBtn = UIButton()
    var loginBtn = UIButton()
    
    //Label
    var loginPromptLbl = UILabel()
    
    func configureButtons() {
        signUpBtn.setTitle("Sign Up", for: .normal)
        signUpBtn.setTitleColor(MWConstants.colors.titleBtnTitle, for: .normal)
        signUpBtn.backgroundColor = UIColor.white
        signUpBtn.layer.cornerRadius = 20.0
        
        loginBtn.setTitle("Log In", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.backgroundColor = UIColor.clear
        loginBtn.layer.cornerRadius = 20.0
        loginBtn.layer.borderColor = UIColor.white.cgColor
        loginBtn.layer.borderWidth = 1
        
    }
    
    func configureLabels() {
        loginPromptLbl.font = UIFont.systemFont(ofSize: 14.0)
        loginPromptLbl.text = "Already signed up?"
        loginPromptLbl.textColor = UIColor.white
        loginPromptLbl.textAlignment = .center
    }
    
    func configureView() {
        self.backgroundColor = UIColor.clear
        configureButtons()
        configureLabels()
        
        let viewsDict = [
            "signUp"    :   signUpBtn,
            "login"     :   loginBtn,
            "prompt"    :   loginPromptLbl
        ] as [String : UIView]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|[signUp(==\(String(describing: MWConstants.titleBtnHeight)))]-25-[prompt]-15-[login(==\(String(describing: MWConstants.titleBtnHeight)))]|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[signUp]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[prompt]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[login]|", views: viewsDict))
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
