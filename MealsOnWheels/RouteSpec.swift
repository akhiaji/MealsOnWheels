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
    var destination: Place?
    var origin: Place?
    var waypoints: Array<Place> = Array<Place>()
    var waypointsArray: Array<Waypoint> = Array<Waypoint>()
    var uid = ""
    var order: Array<Int> = Array<Int>()
    var ref: Firebase! = Firebase(url: "https://mealsonwheels.firebaseio.com")
    let placesClient = GMSPlacesClient()
    var title = ""
    var enforceOrder = false

    init(dict: NSDictionary) {
        super.init()
        title = dict["title"] as! String
        uid = (dict["uid"] as? String)!
        if dict["waypointPlaces"] != nil {
            for i in dict["waypointPlaces"] as! NSArray {
                self.waypoints.append(Place(dict: i as! NSDictionary))
            }
        }
        if dict["waypoints"] != nil {
            for i in dict["waypoints"] as! NSArray {
                self.waypointsArray.append(Waypoint(dict: i as! NSDictionary))
            }
        }
//        }
//                let waypointDict = i as! NSDictionary
//                placesClient.lookUpPlaceID(waypointDict.allKeys[0] as! String, callback: { (place: GMSPlace?, error: NSError?) -> Void in
//                    if let error = error {
//                        print("lookup place id query error: \(error.localizedDescription)")
//                        return
//                    }
//                    if let place = place {
//                        self.waypoints.append(Place(place: place))
//                    }
//                })
//                waypointsArray.append(Waypoint(dict: waypointDict.valueForKey(waypointDict.allKeys[0] as! String) as! NSDictionary))
//            }
//        }
        self.origin = Place(dict: dict["origin"] as! NSDictionary)
        self.destination = Place(dict: dict["destination"] as! NSDictionary)
        
//        placesClient.lookUpPlaceID(dict["origin"] as! String, callback: { (place: GMSPlace?, error: NSError?) -> Void in
//            if let error = error {
//                print("lookup place id query error: \(error.localizedDescription)")
//                return
//            }
//            if let place = place {
//                self.origin = Place(place: place)
//            }
//            
//        })
//        placesClient.lookUpPlaceID(dict["destination"] as! String, callback: { (place: GMSPlace?, error: NSError?) -> Void in
//            if let error = error {
//                print("lookup place id query error: \(error.localizedDescription)")
//                return
//            }
//            if let place = place {
//                self.destination = Place(place: place)
//            }
//            
//        })

        
    }
    init(origin: GMSPlace, destination: GMSPlace, waypoints: Array<GMSPlace>) {
        self.origin = Place(place: origin)
        self.destination = Place(place: destination)
        for waypoint in waypoints {
            self.waypoints.append(Place(place: waypoint))
        }
    }
    
    init(waypoints: Array<GMSPlace>) {
        for waypoint in waypoints {
            self.waypoints.append(Place(place: waypoint))
        }
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
    override func isEqual(object: AnyObject?) -> Bool {
        if let rhs = object as? RouteSpec {
            return self.toDict() == rhs.toDict()
        }
        return false
    }
    
    func toDict() -> NSDictionary {
        let dict = NSMutableDictionary()
        let list = NSMutableArray()
        let list2 = NSMutableArray()
        if order.count == 0 {
            for i in 0 ..< waypoints.count {
                list.addObject(waypointsArray[i].toDict())
                list2.addObject(waypoints[i].toDict())
            }
        } else {
            for i in order {
                list.addObject(waypointsArray[i].toDict())
                list2.addObject(waypoints[i].toDict())
            }
        }
        dict.setObject(origin!.toDict(), forKey: "origin")
        dict.setObject(list, forKey: "waypoints")
        dict.setObject(list2, forKey: "waypointPlaces")
        dict.setObject(destination!.toDict(), forKey: "destination")
        dict.setObject(uid, forKey: "uid")
        dict.setObject(title, forKey: "title")
        dict.setObject(enforceOrder, forKey: "enforceOrder")
        return dict
    }

    
}
