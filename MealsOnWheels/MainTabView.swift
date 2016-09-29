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
    
    //Current Page
    var currentPage = Page.CurrentRoute {
        willSet(newPage) {
            if (newPage != currentPage) {
                switch newPage {
                case .CurrentRoute:
                    currentRoute.backgroundColor = MWConstants.colors.loginDarkGradient
                    myRoutes.backgroundColor = MWConstants.colors.loginLightGradient
                    break
                case .MyRoutes:
                    myRoutes.backgroundColor = MWConstants.colors.loginDarkGradient
                    currentRoute.backgroundColor = MWConstants.colors.loginLightGradient
                    break
                }
            }
        }
    }
    
    func configureButtons() {
        currentRoute.setTitle("Current Route", for: .normal)
        currentRoute.setTitleColor(UIColor.white, for: .normal)
        currentRoute.backgroundColor = MWConstants.colors.loginDarkGradient
        
        myRoutes.setTitle("My Routes", for: .normal)
        myRoutes.setTitleColor(UIColor.white, for: .normal)
        myRoutes.backgroundColor = MWConstants.colors.loginLightGradient
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
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[currBtn(==\(String(describing: MWConstants.screenWidth/2)))]-[myRoutBtn(==\(String(describing: MWConstants.screenWidth/2)))]|", views: viewsDict))
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum Page {
    case CurrentRoute
    case MyRoutes
}
