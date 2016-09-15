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
    static let screenSize = UIScreen.mainScreen().bounds
    static let screenHeight = UIScreen.mainScreen().bounds.height
    static let screenWidth = UIScreen.mainScreen().bounds.width
    
    static let btnWidth = CGFloat(100)
    
    static let loginFieldsOffset = CGFloat((screenWidth / 2)-btnWidth)
    static let logoImg = UIImage(named: "upload-empty")
    
    
    struct colors {
        static let loginBackground = UIColor.blueColor()
    }
}