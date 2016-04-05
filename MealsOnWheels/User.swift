//
//  User.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 2/17/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import Firebase

class User: NSObject {
    static var email: String!
    static var uid: String!
    static var routes: Array<RouteSpec> = Array<RouteSpec>()
    static var routeDic: Array<NSDictionary> = Array<NSDictionary>()
    let ref: Firebase! = Firebase(url: "https://mealsonwheels.firebaseio.com")
    
    override init() {
    }
    
    init(email: String, password: String, errorCase: () -> Void, closure: () -> Void) {
        super.init()
        User.email = email
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            self.ref.authUser(email, password: password, withCompletionBlock: { (error, result) -> Void in
                if error != nil {
                    print("Hello error")
                    errorCase()
                } else {
                    User.uid = result.uid
                    for route in User.routes {
                        User.routeDic.append(route.toDict())
                    }
                    self.ref.childByAppendingPath("users")
                        .childByAppendingPath(result.uid).setValue(User.routeDic as NSArray)
                    let prefs = NSUserDefaults.standardUserDefaults()
                    prefs.setValue(password, forKey: "pass")
                    prefs.setValue(email, forKey: "email")
                    let userRef = self.ref.childByAppendingPath(User.uid).childByAppendingPath("email")
                    userRef.setValue(email)
                    let pathRef = self.ref.childByAppendingPath(User.uid).childByAppendingPath("paths")
                    pathRef.observeEventType(.ChildAdded, withBlock: {snapshot in
                        for child: FDataSnapshot in snapshot.children.allObjects as! [FDataSnapshot] {
                            let dic = child.value as! NSDictionary
                            User.routes.append(RouteSpec.init(dict: dic))
                        }
                    })
                    
                    closure()
                }
            })
        })
    }
    
    
    
    
}