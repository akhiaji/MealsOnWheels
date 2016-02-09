//
//  ResultCell.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 1/17/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class ResultCell: UITableViewCell {
    
    @IBOutlet weak var result: UILabel!
    
    func setLabel(content: String) {
        result.text = content
    }
}
