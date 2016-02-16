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
import CoreData


class RouteViews: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Routes"
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Route")
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            RouteSpec.routes = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could Not Fetch \(error)")
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let route = RouteSpec.routes[indexPath.row]
        let info = route.valueForKey("routeInfo") as? String
        let stuff = info?.componentsSeparatedByString("|")
        let origin = stuff![0]
        let destination = stuff![1]
        let waypoints = stuff![2..<stuff!.count]
        MapTasks.getDirections(origin, destination: destination, waypoints: Array(waypoints), travelMode: nil, completionHandler: { (status, success) -> Void in
            print(status)
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RouteSpec.routes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UIRouteViewCell
        let route = RouteSpec.routes[indexPath.row]
        cell.routeInfo!.text = route.valueForKey("routeDescription") as? String
        return cell
    }
}