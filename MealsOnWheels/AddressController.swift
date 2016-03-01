//
//  AddressController.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 1/17/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps


class AddressController: UIViewController {
    
    @IBOutlet weak var searchBar: UIView!
    @IBOutlet weak var addressType: UISegmentedControl!
    @IBOutlet weak var label: UITextView!
    var searchController: UISearchController!
    var currentField: UITextField!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var mapTasks = MapTasks()
    var wayponts: Array<String> = Array<String>()
    var waypoints: Array<GMSPlace> = Array<GMSPlace>()
    var origin: String!
    var destination: String!
    var routeSpec: RouteSpec?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wayponts = Array<String>()
        origin = ""
        destination = ""
        label.text = ""
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController?.searchBar.sizeToFit()
        searchBar.addSubview((searchController?.searchBar)!)
        searchController?.searchBar.sizeToFit()
        
        self.definesPresentationContext = true
        
        searchController?.hidesNavigationBarDuringPresentation = false
    }
    
    @IBAction func route(sender: AnyObject) {
        let nameAlert = UIAlertController(title: "Title", message: "Title of this route", preferredStyle: UIAlertControllerStyle.Alert)
        nameAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "name?"
        }
        
        let finishAction = UIAlertAction(title: "Route", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            MapTasks.getDirections(self.origin, destination: self.destination, waypoints: self.wayponts, travelMode: nil, completionHandler: { (status, success) -> Void in
                if success {
                    self.routeSpec?.order = MapTasks.order
                    self.routeSpec!.saveData()
                    self.routeSpec = RouteSpec(waypoints: Array<GMSPlace>())
                }
                print(status)
            })
            
            self.performSegueWithIdentifier("showMap", sender: sender)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        nameAlert.addAction(finishAction)
        nameAlert.addAction(cancelAction)
        presentViewController(nameAlert, animated: true, completion: nil)
    }
}

extension AddressController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(resultsController: GMSAutocompleteResultsViewController!, didAutocompleteWithPlace place: GMSPlace!) {
        if (routeSpec == nil) {
            routeSpec = RouteSpec(waypoints: Array<GMSPlace>())
        }
        searchController?.active = false
        print(place.formattedAddress)
        switch(addressType.selectedSegmentIndex) {
        case 2:
            destination = place.formattedAddress + ","
            routeSpec!.destination = place
        case 1:
            wayponts.append(place.formattedAddress + ",")
            routeSpec!.waypoints!.append(place)
            print(place)
        case 0:
            origin = place.formattedAddress + ","
            routeSpec!.origin = place
        default:
            true
        }

        label.text = routeSpec!.toString()
    }
    
    func resultsController(resultsController: GMSAutocompleteResultsViewController!, didFailAutocompleteWithError error: NSError!) {
        print("Error: ", error.description)
    }
}

