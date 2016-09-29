////
////  UserCell.swift
////  MealsOnWheels
////
////  Created by Akhilesh Aji on 4/2/16.
////  Copyright © 2016 Akhilesh. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Firebase
//
//
//class UserCell: UITableViewCell {
//    @IBOutlet var emailLbl: UILabel!
//    var routeSpec: RouteSpec?
//    var user: NSDictionary?
//    var ref = FIRDatabase.database().reference()
//    var userID = ""
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UserCell.share))
//        emailLbl.addGestureRecognizer(tapGesture)
//        self.addGestureRecognizer(tapGesture)
//    }
//    
//    func changeColor(_ color: UIColor) {
//        let text = NSMutableAttributedString(attributedString: emailLbl.attributedText!)
//        text.setAttributes([NSForegroundColorAttributeName: color], range: NSMakeRange(0, text.length))
//        emailLbl.attributedText = text
//    }
//    
//    func share() {
//        let routeRef = ref.child(user!.allKeys[0] as! String).child("paths").child(routeSpec!.uid)
//        
//        routeRef.observe(.value, with: {snapshot in
//            routeRef.removeAllObservers()
//            if snapshot.exists() {
//                self.changeColor(UIColor.red)
//                routeRef.removeValue()
//            } else {
//                self.changeColor(UIColor.green)
//                routeRef.setValue(["data":self.routeSpec!.toDict()])
//            }
//            routeRef.removeAllObservers()
//        })
//    }
//    
//    
//    
//}
