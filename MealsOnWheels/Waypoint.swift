//
//  Waypoint.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 3/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import GoogleMaps


class Waypoint {
    var address: String!
    var phoneNumber: String!
    var info: String!
    var title: String!
    
    init(address: String, phoneNumber: String, info: String, title: String) {
        self.address = address
        self.info = info
        self.phoneNumber = phoneNumber
        self.title = title
    }
    
    init(dict: NSDictionary) {
        self.address = dict["address"] as! String
        self.phoneNumber = dict["phone"]! as! String
        self.info = dict["info"]! as! String
        self.title = dict["title"]! as! String
    }
    
    func toDict() -> NSDictionary {
        let dict = NSMutableDictionary()
        dict.setObject(address!, forKey: "address" as NSCopying)
        dict.setObject(phoneNumber!, forKey: "phone" as NSCopying)
        dict.setObject(info!, forKey: "info" as NSCopying)
        dict.setObject(title!, forKey: "title" as NSCopying)
        return dict
    }
}
