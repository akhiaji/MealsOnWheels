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
    var origin: String!
    var destination: String!
    
    
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
        print("hello")
        
        
    }
    
    @IBAction func route(sender: AnyObject) {
        MapTasks.getDirections(origin, destination: destination, waypoints: wayponts, travelMode: nil, completionHandler: { (status, success) -> Void in
            print(status)
        })
    }
}

extension AddressController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(resultsController: GMSAutocompleteResultsViewController!, didAutocompleteWithPlace place: GMSPlace!) {
        searchController?.active = false
        print(place.formattedAddress)
        switch(addressType.selectedSegmentIndex) {
        case 2:
            destination = place.formattedAddress + ","
        case 1:
            wayponts.append(place.formattedAddress + ",")
        case 0:
            origin = place.formattedAddress + ","
        default:
            true
        }
        var shortStart = ""
        if let segment = origin.rangeOfString(",") {
            shortStart = origin.substringToIndex(segment.startIndex)
        }
        var shortEnd = ""
        if let segment = destination.rangeOfString(",") {
            shortEnd = destination.substringToIndex(segment.startIndex)
        }
//        var waypointsString = ""
//        if wayponts != nil {
//            waypointsString = wayponts.description
//        }
        label.text = "Start: \(shortStart)| End: \(shortEnd)\n \(wayponts.description)"
    }
    
    func resultsController(resultsController: GMSAutocompleteResultsViewController!, didFailAutocompleteWithError error: NSError!) {
        print("Error: ", error.description)
    }
}

