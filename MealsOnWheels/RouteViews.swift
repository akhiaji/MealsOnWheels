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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Routes"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RouteSpec.routes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        let route = RouteSpec.routes[indexPath.row]
        cell!.textLabel!.text = route.valueForKey("routeDescription") as? String
        return cell!
    }
}