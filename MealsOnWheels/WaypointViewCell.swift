//
//  WaypointViewCell.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 3/27/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class WaypointViewCell: UITableViewCell, UITextViewDelegate {
    
    var route: RouteSpec?
    var waypoint: Waypoint?
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var phoneNmbrLbl: UILabel!
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    @IBOutlet weak var DescripionTitle: UILabel!
    @IBOutlet weak var descriptionBody: UITextView!
    var height: CGFloat?

    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionBody.delegate = self
        height = CGRectGetHeight(nameLbl.frame)
        height = height! + CGRectGetHeight(nameTxtFld.frame)
        height = height! + CGRectGetHeight(phoneNmbrLbl.frame)
        height = height! + CGRectGetHeight(phoneNumberTxtField.frame)
        height = height! + CGRectGetHeight(descriptionBody.frame)
        height = height! + CGRectGetHeight(DescripionTitle.frame)
        
        
        
    }
    @IBAction func changeName(sender: UITextField) {
        waypoint?.title = nameLbl.text
        route?.saveData()
    }
    @IBAction func changePhone(sender: UITextField) {
        waypoint?.phoneNumber = phoneNumberTxtField.text
        route?.saveData()
    }
    func textViewDidChange(textView: UITextView) {
        waypoint?.info = textView.text
        route?.saveData()
        
    }
    
    
    
    
}
