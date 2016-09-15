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
        
    }
    
    func configureView() {
        
        configureButtons()
        
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        configureView()
    }
}