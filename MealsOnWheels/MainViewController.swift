//
//  MainViewConroller.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 2/17/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import SwiftLoader
import UIKit

class MainViewController: UIViewController {
    
    var mainView = MainView();
    
    func configureButtons() {
        mainView.tabView.currentRoute.addTarget(self, action: #selector(switchPage(_:)), for: .touchUpInside)
        
        mainView.tabView.myRoutes.addTarget(self, action: #selector(switchPage(_:)), for: .touchUpInside)
    }
    
    func configureView() {
        
        configureButtons()
        
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        configureView()
    }
    
    func switchPage(_ sender: UIButton) {
        if sender == mainView.tabView.currentRoute {
            mainView.tabView.currentPage = Page.CurrentRoute
        } else if sender == mainView.tabView.myRoutes {
            mainView.tabView.currentPage = Page.MyRoutes
        }
    }
}
