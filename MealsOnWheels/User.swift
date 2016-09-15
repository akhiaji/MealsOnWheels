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
    var ref = FIRDatabase.database().reference()
    
    override init() {
    }
    
    init(email: String, password: String, errorCase: () -> Void, closure: () -> Void) {
        super.init()
        User.email = email
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error)-> Void in
                if error != nil {
                    print("Hello error")
                    errorCase()
                } else {
                    User.uid = user!.uid
                    for route in User.routes {
                        User.routeDic.append(route.toDict())
                    }
                    self.ref.child("users").child(user!.uid).setValue(User.routeDic as NSArray)
                    let prefs = NSUserDefaults.standardUserDefaults()
                    prefs.setValue(password, forKey: "pass")
                    prefs.setValue(email, forKey: "email")
                    let userRef = self.ref.child(User.uid).child("email")
                    userRef.setValue(email)
                    let pathRef = self.ref.child(User.uid).child("paths")
                    User.routes.removeAll()
                    pathRef.observeEventType(.ChildAdded, withBlock: {snapshot in
                        for child: FIRDataSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                            let dic = child.value as! NSDictionary
                            User.routes.append(RouteSpec.init(dict: dic))
                        }
                    })
                    pathRef.observeEventType(.ChildRemoved, withBlock: {snapshot in
                        for child: FIRDataSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                            let dic = child.value as! NSDictionary
                            let routeSpec = RouteSpec.init(dict: dic["data"]  as! NSDictionary)
                            for i in 0 ..< User.routes.count {
                                let route = User.routes[i]
                                if routeSpec == route {
                                    User.routes.removeAtIndex(i)
                                }
                            }
                        }
                    })
                    
                    closure()
                }
            })
        })
    }
    
    
    
    
}