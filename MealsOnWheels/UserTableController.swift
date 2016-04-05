//
//  UserTableController.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 4/2/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class UserTableController: UITableViewController {
    
    var objectNum = -1
    let ref: Firebase! = Firebase(url: "https://mealsonwheels.firebaseio.com")
    var users: Array<NSDictionary> = Array<NSDictionary>()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ref.observeEventType(.Value, withBlock: {snapshot in
            for child: FDataSnapshot in snapshot.children.allObjects as! [FDataSnapshot] {
                let dict = child.value as! NSDictionary
                
                self.tableView.beginUpdates()
                self.users.append([child.key : dict["email"]!])
//                let cell = UserCell()
//                let user = child.key as String
//                let routeRef = self.ref.childByAppendingPath(user).childByAppendingPath("paths").childByAppendingPath(User.routes[self.objectNum].uid)
//                routeRef.observeEventType(.Value, withBlock: {snapshot in
//                    if snapshot.exists() {
//                        let text = NSMutableAttributedString(string: dict["email"] as! String)
//                        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSMakeRange(0, text.length))
//                        cell.emailLbl.attributedText = text
//                    } else {
//                        let text = NSMutableAttributedString(string: dict["email"] as! String)
//                        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, text.length))
//                        cell.emailLbl.attributedText = text
//                        
//                        routeRef.removeValue()
//                    }
//                })
                self.tableView.insertRowsAtIndexPaths([NSIndexPath(indexes: [0,self.users.count - 1], length: 2)], withRowAnimation: UITableViewRowAnimation.Automatic)
                self.tableView.endUpdates()
            }
            
            self.ref.removeAllObservers()
        })
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell") as! UserCell
        let user = users[indexPath.row]
        let routeRef = ref.childByAppendingPath(user.allKeys[0] as! String).childByAppendingPath("paths").childByAppendingPath(User.routes[objectNum].uid)
        routeRef.observeEventType(.Value, withBlock: {snapshot in
            if snapshot.exists() {
                let text = NSMutableAttributedString(string: user[user.allKeys[0] as! String] as! String)
                text.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSMakeRange(0, text.length))
                cell.routeSpec = User.routes[self.objectNum]
                cell.user = user
                cell.emailLbl.attributedText = text
            } else {
                let text = NSMutableAttributedString(string: user[user.allKeys[0] as! String] as! String)
                text.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, text.length))
                cell.routeSpec = User.routes[self.objectNum]
                cell.user = user
                cell.emailLbl.attributedText = text

                routeRef.removeValue()
            }
            routeRef.removeAllObservers()
        })
        return cell
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let user = users[indexPath.row]
//        let routeRef = ref.childByAppendingPath(user.allKeys[0] as! String).childByAppendingPath("paths").childByAppendingPath(User.routes[objectNum].uid)
//        
//        routeRef.observeEventType(.Value, withBlock: {snapshot in
//            routeRef.removeAllObservers()
//            if snapshot.exists() {
//                let cell = tableView.cellForRowAtIndexPath(indexPath) as! UserCell
//                cell.changeColor(UIColor.redColor())
//                routeRef.removeValue()
//            } else {
//                let text = NSMutableAttributedString(string: user[user.allKeys[0] as! String] as! String)
//                text.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSMakeRange(0, text.length))
//                tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.attributedText = text
//                routeRef.setValue(["data":User.routes[self.objectNum].toDict()])
//            }
//            routeRef.removeAllObservers()
//        })
//        
//        
//    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
}