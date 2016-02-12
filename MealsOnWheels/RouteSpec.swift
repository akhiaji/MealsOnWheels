//
//  RouteSpec.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 2/10/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import GoogleMaps
import CoreData

class RouteSpec: NSObject {
    static var routes = [NSManagedObject]()
    var origin: GMSPlace?
    var destination: GMSPlace?
    var waypoints: Array<GMSPlace>?
    
    init(origin: GMSPlace, destination: GMSPlace, waypoints: Array<GMSPlace>) {
        self.origin = origin
        self.destination = destination
        self.waypoints = waypoints
    }
    init(waypoints: Array<GMSPlace>) {
        self.waypoints = waypoints
    }
    
    func toString() -> String{
        return "Start: \(origin!.name)| End: \(destination!.name)\n \(waypoints!.description)"
    }
    
    func infoString() -> String{
        var names = ""
        for place in waypoints! {
            names += "|" + place.name
        }
        return "\(origin!.name)|\(destination!.name)|\(names)"
    }
    
    func saveData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("Route", inManagedObjectContext: managedContext)
        let route = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        route.setValue(toString(), forKey: "routeDescription")
        route.setValue(toString(), forKey: "routeInfo")
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could Not Save\(error)")
        }
    }
}
