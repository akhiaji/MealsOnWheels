////
////  RouteViews.swift
////  MealsOnWheels
////
////  Created by Akhilesh Aji on 2/11/16.
////  Copyright © 2016 Akhilesh. All rights reserved.
////
//
//import Foundation
//import UIKit
//import GoogleMaps
//
//
//class RouteViews: UITableViewController {
//    
//
//    
//    @IBOutlet var table: UITableView!
//    @IBOutlet weak var navBar: UINavigationBar!
//    var refresher = UIRefreshControl()
//    var objectNum = 0
//    var localRoutes = Array<RouteSpec>()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Routes"
//        for route in User.routes {
//            localRoutes.append(route)
//        }
//        tableView.rowHeight = UITableViewAutomaticDimension
//        self.tableView = self.tableView
//        self.refreshControl = refresher
//        self.refresher.addTarget(self, action: #selector(RouteViews.update), for: .valueChanged)
//        
//    }
//    
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async(execute: {() -> Void in
////            while (self.isViewLoaded()) {
////                if (self.localRoutes.count != User.routes.count) {
////                    self.update()
////                }
////                print("hello")
////            }
//        })
//    }
//    
//
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let stuff = localRoutes[(indexPath as NSIndexPath).row]
//        var waypoints = Array<String>()
//        for place in stuff.waypoints {
//            waypoints.append(place.formattedAddress!)
//        }
//        MapTasks.waypointsArray = stuff.waypointsArray
//        MapTasks.getDirections(stuff.origin?.formattedAddress, destination: stuff.destination!.formattedAddress, waypointsTemp: waypoints, travelMode: nil, completionHandler: { (status, success) -> Void in
//            print(status)
//        })
//        switchView((indexPath as NSIndexPath).row)
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return localRoutes.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UIRouteViewCell
//        let route = localRoutes[(indexPath as NSIndexPath).row]
//        cell.routeInfo!.text = route.title
//        return cell
//    }
//    
//    func update() {
//        self.refresher.endRefreshing()
////        for (var i = localRoutes.count; i < User.routes.count; i += 1) {
////            self.localRoutes.append(User.routes[i])
////            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: i, inSection: 0)], withRowAnimation: .Automatic)
////        }
//        self.localRoutes = User.routes
//        self.tableView.reloadData()
//    }
//    
//
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "details") {
//            (segue.destination as! RouteDetails).objectNum = objectNum
//            
//        }
//    }
//    
//    func switchView(_ row: Int) {
//        objectNum = row
//        performSegue(withIdentifier: "details", sender: self)
//    }
//}
