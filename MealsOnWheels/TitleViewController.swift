//
//  TitleViewController.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 9/29/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class TitleViewController: UIViewController {
    
    func configureView() {
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [MWConstants.colors.loginDarkGradient.cgColor, MWConstants.colors.loginLightGradient.cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
