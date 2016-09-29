//
//  RegistrationEmailView.swift
//  MealsOnWheels
//
//  Created by Taabish Kathawala on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class RegistrationEmailView: UIView {
    

    //Text fields
    var emailTF = UITextField()
    var passTF = UITextField()
    var passConfirmTF = UITextField()

    func configureTextFields() {
        emailTF.placeholder = "Email Address"
        
        passTF.placeholder = "Password"
        
        passConfirmTF.placeholder = "Confirm Password"
        
        emailTF.backgroundColor = UIColor.whiteColor()
        passTF.backgroundColor = UIColor.whiteColor()
        passConfirmTF.backgroundColor = UIColor.whiteColor()
        
    }
    
    func configureView() {
        self.backgroundColor = UIColor.init(r: 209, g: 217, b: 233, a: 1.0)

        
        configureTextFields()
        
        //Auto Layout
        let viewsDict = [
            "emailTF"   :   emailTF,
            "passTF"    :   passTF,
            "confirmTF" :   passConfirmTF
        ]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-20-[emailTF]-20-[passTF]-20-[confirmTF]", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(MWConstants.loginFieldsOffset))-[emailTF]-\(String(MWConstants.loginFieldsOffset))-|", views: viewsDict))
    
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(MWConstants.loginFieldsOffset))-[passTF]-\(String(MWConstants.loginFieldsOffset))-|", views: viewsDict))
    
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(MWConstants.loginFieldsOffset))-[confirmTF]-\(String(MWConstants.loginFieldsOffset))-|", views: viewsDict))
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
}