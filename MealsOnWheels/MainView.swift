//
//  MainView.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class MainView: UIView {
    
    //Views
    var tabView = MainTabView();
    var currentRouteView = CurrentRouteView();
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.loginBackground
        
        //Auto Layout
        let viewsDict = [
            "tabView"  :   tabView,
            "currView"  :   currentRouteView
        ] as [String : Any]
        
        self.prepareViewsForAutoLayout(viewsDict as! [String : UIView])
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|[currView]-[tabView(==\(String(describing: MWConstants.screenHeight/8)))]|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[tabView]|", views: viewsDict as [String : AnyObject]))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[currView]|", views: viewsDict as [String : AnyObject]))
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
