//
//  UserCell.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 4/2/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//


import Foundation
import UIKit
import Firebase


class UserCell: UITableViewCell {
    @IBOutlet var emailLbl: UILabel!
    var routeSpec: RouteSpec?
    var user: NSDictionary?
    let ref: Firebase! = Firebase(url: "https://mealsonwheels.firebaseio.com")
    var userID = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: "share")
        emailLbl.addGestureRecognizer(tapGesture)
        self.addGestureRecognizer(tapGesture)
    }
    
    func changeColor(color: UIColor) {
        let text = NSMutableAttributedString(attributedString: emailLbl.attributedText!)
        text.setAttributes([NSForegroundColorAttributeName: color], range: NSMakeRange(0, text.length))
        emailLbl.attributedText = text
    }
    
    func share() {
        let routeRef = ref.childByAppendingPath(user!.allKeys[0] as! String).childByAppendingPath("paths").childByAppendingPath(routeSpec!.uid)
        
        routeRef.observeEventType(.Value, withBlock: {snapshot in
            routeRef.removeAllObservers()
            if snapshot.exists() {
                self.changeColor(UIColor.redColor())
                routeRef.removeValue()
            } else {
                self.changeColor(UIColor.greenColor())
                routeRef.setValue(["data":self.routeSpec!.toDict()])
            }
            routeRef.removeAllObservers()
        })
    }
    
    
    
}
