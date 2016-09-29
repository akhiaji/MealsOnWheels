//
//  TitleView.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 9/29/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class TitleView: UIView {
    
    //Button Hub
    var buttonHub = TitleViewButtonHub()
    
    //Image View
    var titleImgView = UIImageView()
    
    func configureImageView() {
        titleImgView.image = MWConstants.titleImg
        titleImgView.contentMode = .scaleAspectFit
    }
    
    func configureView() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [MWConstants.colors.loginDarkGradient.cgColor, MWConstants.colors.loginLightGradient.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
        
        configureImageView()
        
        let viewsDict = [
            "title"     :   titleImgView,
            "btnHub"    :   buttonHub
            ] as [String : UIView]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:[title]-100-[btnHub]-100-|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.titleBtnHOffset))-[btnHub(==\(String(describing: MWConstants.titleBtnWidth)))]", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-30-[title]-30-|", views: viewsDict))
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
