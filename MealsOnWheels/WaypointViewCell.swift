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
        height = nameLbl.frame.height
        height = height! + nameTxtFld.frame.height
        height = height! + phoneNmbrLbl.frame.height
        height = height! + phoneNumberTxtField.frame.height
        height = height! + descriptionBody.frame.height
        height = height! + DescripionTitle.frame.height
        
        
        
    }
    @IBAction func changeName(_ sender: UITextField) {
        waypoint?.title = nameTxtFld.text
        route?.saveData()
    }
    @IBAction func changePhone(_ sender: UITextField) {
        waypoint?.phoneNumber = phoneNumberTxtField.text
        route?.saveData()
    }
    func textViewDidChange(_ textView: UITextView) {
        waypoint?.info = textView.text
        route?.saveData()
        
    }
    
    
    
    
}
