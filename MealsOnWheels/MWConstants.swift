//
//  MWConstants.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

struct MWConstants {
    
    //Screen Size
    static let screenSize = UIScreen.main.bounds
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    
    static let btnWidth = CGFloat(100)
    
    static let loginFieldsOffset = CGFloat((screenWidth / 2)-btnWidth)
    static let logoImg = UIImage(named: "upload-empty")
    
    
    struct colors {
        static let loginBackground = UIColor.blue
        static let loginDarkGradient = UIColor(r: 24, g: 51, b: 78, a: 1.0)
        static let loginLightGradient = UIColor(r: 36, g: 77, b: 117, a: 1.0)
    }
}