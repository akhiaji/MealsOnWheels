//
//  RouteSpec.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 2/10/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import GoogleMaps
import Firebase

class RouteSpec: NSObject {
    var origin: GMSPlace?
    var destination: GMSPlace?
    var waypoints: Array<GMSPlace> = Array<GMSPlace>()
    var waypointsArray: Array<Waypoint> = Array<Waypoint>()
    var uid = ""
    var order: Array<Int> = Array<Int>()
    var ref: Firebase! = Firebase(url: "https://mealsonwheels.firebaseio.com")
    let placesClient = GMSPlacesClient()
    var title = ""

    init(dict: NSDictionary) {
        super.init()
        title = dict["title"] as! String
        uid = (dict["uid"] as? String)!
        
        if dict["waypoints"] != nil {
            for i in dict["waypoints"] as! NSArray {
                let waypointDict = i as! NSDictionary
                placesClient.lookUpPlaceID(waypointDict.allKeys[0] as! String, callback: { (place: GMSPlace?, error: NSError?) -> Void in
                    if let error = error {
                        print("lookup place id query error: \(error.localizedDescription)")
                        return
                    }
                    if let place = place {
                        self.waypoints.append(place)
                    }
                })
                waypointsArray.append(Waypoint(dict: waypointDict.valueForKey(waypointDict.allKeys[0] as! String) as! NSDictionary))
            }
        }
        
        placesClient.lookUpPlaceID(dict["origin"] as! String, callback: { (place: GMSPlace?, error: NSError?) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            if let place = place {
                self.origin = place
            }
            
        })
        placesClient.lookUpPlaceID(dict["destination"] as! String, callback: { (place: GMSPlace?, error: NSError?) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            if let place = place {
                self.destination = place
            }
            
        })

        
    }
    init(origin: GMSPlace, destination: GMSPlace, waypoints: Array<GMSPlace>) {
        self.origin = origin
        self.destination = destination
        self.waypoints = waypoints
    }
    init(waypoints: Array<GMSPlace>) {
        self.waypoints = waypoints
    }
    
    func toString() -> String{
        var origin = ""
        if self.origin != nil {
            origin = (self.origin?.name)!
        }
        var destination = ""
        if self.destination != nil {
            destination = (self.destination?.name)!
        }
        var waypointsS = ""
        for place in self.waypoints {
            waypointsS += "|" + place.name
        }
        
        
        return "Start: \(origin)| End: \(destination)\n \(waypointsS)"
    }
    
    func infoString() -> String{
        var names = ""
        for place in waypoints {
            names += "|" + place.formattedAddress
        }
        return "\(origin!.formattedAddress)|\(destination!.formattedAddress)\(names)"
    }
    
    func saveData() {
        var saveRef = ref
        if (self.uid == "") {
            saveRef = ref.childByAppendingPath(User.uid).childByAppendingPath("paths").childByAutoId()
            self.uid = saveRef.key
        } else {
            saveRef = ref.childByAppendingPath(User.uid).childByAppendingPath("paths").childByAppendingPath(self.uid)
        }
        let path = ["data": toDict()] as NSDictionary
        saveRef.setValue(path)
    }
    
    func toDict() -> NSDictionary {
        let dict = NSMutableDictionary()
        let list = NSMutableArray()
        if order.count == 0 {
            for var i = 0; i < waypoints.count; i++ {
                list.addObject(NSDictionary(dictionary: [waypoints[i].placeID: waypointsArray[i].toDict()]))
            }
        } else {
            for i in order {
                list.addObject(NSDictionary(dictionary: [waypoints[i].placeID: waypointsArray[i].toDict()]))
            }
        }
        dict.setObject((origin?.placeID)!, forKey: "origin")
        dict.setObject(list, forKey: "waypoints")
        dict.setObject((destination?.placeID)!, forKey: "destination")
        dict.setObject(uid, forKey: "uid")
        dict.setObject(title, forKey: "title")
        return dict
    }

    
}
