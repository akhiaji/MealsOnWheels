//
//  RouteViews.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 2/11/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps


class RouteViews: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    var objectNum = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Routes"
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadRoutes() {
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let stuff = User.routes[indexPath.row]
        var waypoints = Array<String>()
        for place in stuff.waypoints {
            waypoints.append(place.formattedAddress)
        }
        MapTasks.waypointsArray = stuff.waypointsArray
        MapTasks.getDirections(stuff.origin?.formattedAddress, destination: stuff.destination!.formattedAddress, waypoints: waypoints, travelMode: nil, completionHandler: { (status, success) -> Void in
            print(status)
        })
        switchView(indexPath.row)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.routes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UIRouteViewCell
        let route = User.routes[indexPath.row]
        cell.routeInfo!.text = route.title
        return cell
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "details") {
            (segue.destinationViewController as! RouteDetails).objectNum = objectNum
            
        }
    }
    
    func switchView(row: Int) {
        objectNum = row
        performSegueWithIdentifier("details", sender: self)
    }
}