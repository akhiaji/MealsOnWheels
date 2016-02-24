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
    static var routes: Array<RouteSpec>!
    let ref: Firebase! = Firebase(url: "https://MealsOnWheels.firebaseio.com")
    
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
                    let prefs = NSUserDefaults.standardUserDefaults()
                    prefs.setValue(password, forKey: "pass")
                    prefs.setValue(email, forKey: "email")
                    closure()
                }
            })
        })
        
        
        
    }
    
    
}