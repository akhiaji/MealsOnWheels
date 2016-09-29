////
////  RouteDetails.swift
////  MealsOnWheels
////
////  Created by Akhilesh Aji on 3/15/16.
////  Copyright © 2016 Akhilesh. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//class RouteDetails: UITableViewController {
//    var objectNum = 0
//    var selectedRow = -1
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Routes"
//        tableView.rowHeight = UITableViewAutomaticDimension
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//    }
//    
//    func loadRoutes() {
//        
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        if (selectedRow != -1 && selectedRow == indexPath.row) {
////            let cell = tableView.cellForRowAtIndexPath(indexPath) as! WaypointViewCell
////            return cell.height!
////        } else {
////            return UITableViewAutomaticDimension
////        }
//        return 200;
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return User.routes[objectNum].waypointsArray.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WaypointCell") as! WaypointViewCell
//        let waypoint = User.routes[objectNum].waypointsArray[(indexPath as NSIndexPath).row]
//        cell.route = User.routes[objectNum]
//        cell.waypoint = waypoint
//        cell.nameTxtFld.text = waypoint.title
//        cell.phoneNumberTxtField.text = waypoint.phoneNumber
//        cell.descriptionBody.text = waypoint.info
//        return cell
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        (segue.destination as! UserTableController).objectNum = objectNum
//        if segue.identifier == "share" {
//        }
//    }
//}
