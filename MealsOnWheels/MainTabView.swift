//
//  MainTabView.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class MainTabView: UIView {
    
    //Buttons
    var currentRoute = UIButton()
    var myRoutes = UIButton()
    
    func configureButtons() {
        currentRoute.setTitle("Current Route", forState: .Normal)
        currentRoute.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        currentRoute.backgroundColor = UIColor.darkGrayColor()
        
        myRoutes.setTitle("My Routes", forState: .Normal)
        myRoutes.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        myRoutes.backgroundColor = UIColor.grayColor()
    }
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.loginBackground
        
        configureButtons()
        
        //Auto Layout
        let viewsDict = [
            "currBtn"  :   currentRoute,
            "myRoutBtn"  :   myRoutes
        ]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|[currBtn]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|[myRoutBtn]|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[currBtn(==\(String(MWConstants.screenWidth/2)))]-[myRoutBtn(==\(String(MWConstants.screenWidth/2)))]|", views: viewsDict))
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}