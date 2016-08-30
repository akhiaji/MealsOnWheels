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


class RouteViews: UITableViewController {
    

    
    @IBOutlet var table: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    var refresher = UIRefreshControl()
    var objectNum = 0
    var localRoutes = Array<RouteSpec>()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Routes"
        for route in User.routes {
            localRoutes.append(route)
        }
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView = self.tableView
        self.refreshControl = refresher
        self.refresher.addTarget(self, action: #selector(RouteViews.update), forControlEvents: .ValueChanged)
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {() -> Void in
//            while (self.isViewLoaded()) {
//                if (self.localRoutes.count != User.routes.count) {
//                    self.update()
//                }
//                print("hello")
//            }
        })
    }
    

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let stuff = localRoutes[indexPath.row]
        var waypoints = Array<String>()
        for place in stuff.waypoints {
            waypoints.append(place.formattedAddress!)
        }
        MapTasks.waypointsArray = stuff.waypointsArray
        MapTasks.getDirections(stuff.origin?.formattedAddress, destination: stuff.destination!.formattedAddress, waypointsTemp: waypoints, travelMode: nil, completionHandler: { (status, success) -> Void in
            print(status)
        })
        switchView(indexPath.row)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localRoutes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UIRouteViewCell
        let route = localRoutes[indexPath.row]
        cell.routeInfo!.text = route.title
        return cell
    }
    
    func update() {
        self.refresher.endRefreshing()
//        for (var i = localRoutes.count; i < User.routes.count; i += 1) {
//            self.localRoutes.append(User.routes[i])
//            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: i, inSection: 0)], withRowAnimation: .Automatic)
//        }
        self.localRoutes = User.routes
        self.tableView.reloadData()
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