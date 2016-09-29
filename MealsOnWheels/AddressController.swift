////
////  AddressController.swift
////  MealsOnWheels
////
////  Created by Akhilesh Aji on 1/17/16.
////  Copyright © 2016 Akhilesh. All rights reserved.
////
//
//import Foundation
//import UIKit
//import GoogleMaps
//
//
//class AddressController: UIViewController {
//    @IBOutlet weak var addressType: UISegmentedControl!
//    @IBOutlet weak var label: UITextView!
//    @IBOutlet weak var searchView: UIView!
//    var searchController: UISearchController!
//    var currentField: UITextField!
//    var resultsViewController: GMSAutocompleteResultsViewController?
//    var mapTasks = MapTasks()
//    var wayponts: Array<String> = Array<String>()
//    var waypoints: Array<GMSPlace> = Array<GMSPlace>()
//    var origin: String!
//    var destination: String!
//    var routeSpec: RouteSpec?
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        wayponts = Array<String>()
//        origin = ""
//        destination = ""
//        label.text = ""
//        resultsViewController = GMSAutocompleteResultsViewController()
//        resultsViewController?.delegate = self
//        
//        
//        searchController = UISearchController(searchResultsController: resultsViewController)
//        searchController?.searchResultsUpdater = resultsViewController
//        self.searchView.addSubview((searchController?.searchBar)!)
//        print(searchController.view.bounds)
//        
//        self.definesPresentationContext = true;
//        searchController?.hidesNavigationBarDuringPresentation = false
//    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: searchView.frame.width,height: searchView.frame.height)
//    }
//    
//    @IBAction func route(_ sender: AnyObject) {
//        let nameAlert = UIAlertController(title: "Title", message: "Title of this route", preferredStyle: UIAlertControllerStyle.alert)
//        nameAlert.addTextField { (textField) -> Void in
//            textField.placeholder = "name?"
//        }
//        
//        let finishAction = UIAlertAction(title: "Route", style: UIAlertActionStyle.default) { (alertAction) -> Void in
//            MapTasks.waypointsArray = (self.routeSpec?.waypointsArray)!
//            MapTasks.getDirections(self.origin, destination: self.destination, waypointsTemp: self.wayponts, travelMode: nil, completionHandler: { (status, success) -> Void in
//                if success {
//                    self.routeSpec!.title = nameAlert.textFields![0].text!
//                    self.routeSpec?.order = MapTasks.order
//                    self.routeSpec!.saveData()
//                    self.routeSpec = RouteSpec(waypoints: Array<GMSPlace>())
//                }
//                print(status)
//            })
//            
////            self.performSegueWithIdentifier("showMap", sender: sender)
//            self.navigationController?.popToRootViewController(animated: true) 
//        }
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
//            
//        }
//        nameAlert.addAction(finishAction)
//        nameAlert.addAction(cancelAction)
//        present(nameAlert, animated: true, completion: nil)
//    }
//}
//
//extension AddressController: GMSAutocompleteResultsViewControllerDelegate {
//    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
//        if (routeSpec == nil) {
//            routeSpec = RouteSpec(waypoints: Array<GMSPlace>())
//        }
//        searchController?.isActive = false
//        print(place.formattedAddress)
//        switch(addressType.selectedSegmentIndex) {
//        case 2:
//            destination = place.formattedAddress! + ","
//            routeSpec!.destination = Place(place: place)
//        case 1:
//            wayponts.append(place.formattedAddress! + ",")
//            routeSpec!.waypoints.append(Place(place: place))
//            routeSpec!.waypointsArray.append(Waypoint(address: place.formattedAddress!, phoneNumber: "None", info: "No Information", title: place.name))
//            print(place)
//        case 0:
//            origin = place.formattedAddress! + ","
//            routeSpec!.origin = Place(place: place)
//        default:
//            true
//        }
//
//        label.text = routeSpec!.toString()
//    }
//    
//    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: NSError) {
//        print("Error: ", error.description)
//    }
//}
//
