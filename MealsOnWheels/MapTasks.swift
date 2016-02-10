//
//  MapTask.swift
//  MealsOnWheels
//
//  Created by Akhilesh on 12/17/15.
//  Copyright (c) 2015 Akhilesh. All rights reserved.
//

import Foundation
import GoogleMaps

class MapTasks : NSObject {
    
    let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
    
    var lookupAddressResults: Dictionary<NSObject, AnyObject>!
    
    var fetchedFormattedAddress: String!
    
    var fetchedAddressLongitude: Double!
    
    var fetchedAddressLatitude: Double!
    
    
    static let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"
    
    static var selectedRoute: Dictionary<NSObject, AnyObject>!
    
    static var overviewPolyline: Dictionary<NSObject, AnyObject>!
    
    static var originCoordinate: CLLocationCoordinate2D!
    
    static var destinationCoordinate: CLLocationCoordinate2D!
    
    static var originAddress: String!
    
    static var destinationAddress: String!
    
    static var totalDistanceInMeter: UInt = 0
    
    static var totalDistance: String!
    
    static var totalDurationInSeconds: UInt = 0
    
    static var totalDuration: String!
    
    static var steps: Array<Step>! = Array<Step>()
    
    static var markerLoc = Array<CLLocationCoordinate2D>()
    
    
    override init() {
        super.init()
    }
    
    func geocodeAddress(address: String!, withCompletionHandler completionHandler: ((status: String, success: Bool) -> Void)) {
        if var lookupAddress = address {
            lookupAddress = lookupAddress.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            let geocodeURLString = baseURLGeocode + "address=" + lookupAddress
            
            let geocodeURL = NSURL(string: geocodeURLString)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let geocodingResultsData = NSData(contentsOfURL: geocodeURL!)
                do {
                    let dictionary: Dictionary<NSObject, AnyObject> = try NSJSONSerialization.JSONObjectWithData(geocodingResultsData!, options: NSJSONReadingOptions.MutableContainers) as! Dictionary<NSObject, AnyObject>

                    // Get the response status.
                    let status = dictionary["status"] as! String
                
                    if status == "OK" {
                        let allResults = dictionary["results"] as! Array<Dictionary<NSObject, AnyObject>>
                        self.lookupAddressResults = allResults[0]
                    
                        // Keep the most important values.
                        self.fetchedFormattedAddress = self.lookupAddressResults["formatted_address"] as! String
                        let geometry = self.lookupAddressResults["geometry"] as! Dictionary<NSObject, AnyObject>
                        self.fetchedAddressLongitude = ((geometry["location"] as! Dictionary<NSObject, AnyObject>)["lng"] as! NSNumber).doubleValue
                        self.fetchedAddressLatitude = ((geometry["location"] as! Dictionary<NSObject, AnyObject>)["lat"] as! NSNumber).doubleValue
                    
                        completionHandler(status: status, success: true)
                    }
                    else {
                        completionHandler(status: status, success: false)
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                    completionHandler(status: "", success: false)
                }
            })
        }
        else {
            completionHandler(status: "No valid address.", success: false)
        }
    }
    
    func findAddresses(address: String!, withCompletionHandler completionHandler: ((addresses: Array<String>, status: String, success: Bool) -> Void)) {
        if var lookupAddress = address {
            lookupAddress = lookupAddress.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            let geocodeURLString = baseURLGeocode + "address=" + lookupAddress
            
            let geocodeURL = NSURL(string: geocodeURLString)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let geocodingResultsData = NSData(contentsOfURL: geocodeURL!)
                do {
                    let dictionary: Dictionary<NSObject, AnyObject> = try NSJSONSerialization.JSONObjectWithData(geocodingResultsData!, options: NSJSONReadingOptions.MutableContainers) as! Dictionary<NSObject, AnyObject>
                    
                    // Get the response status.
                    let status = dictionary["status"] as! String
                    
                    if status == "OK" {
                        let allResults = dictionary["results"] as! Array<Dictionary<NSObject, AnyObject>>
                        var allOptions = [String]()
                        for option in allResults {
                            allOptions.append(option["formatted_address"] as! String)
                        }
                        completionHandler(addresses: allOptions, status: status, success: true)
                    }
                    else {
                        completionHandler(addresses: [String](), status: status, success: false)
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                    completionHandler(addresses: [String](), status: "", success: false)
                }
            })
        }
        else {
            completionHandler(addresses: [String](), status: "No valid address.", success: false)
        }
    }

    
    static func getDirections(origin: String!, destination: String!, waypoints: Array<String>!, travelMode: AnyObject!, completionHandler: ((status: String, success: Bool) -> Void)) {
        if let originLocation = origin {
            if let destinationLocation = destination {
                var directionsURLString = baseURLDirections + "origin=" + originLocation + "&destination=" + destinationLocation
                if let routeWaypoints = waypoints {
                    directionsURLString += "&waypoints=optimize:true"
                    for waypoint in routeWaypoints {
                        directionsURLString += "|"+waypoint
                    }
                }
                directionsURLString = directionsURLString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
                let directionsURL = NSURL(string: directionsURLString)
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    let directionsData = NSData(contentsOfURL: directionsURL!)
                    
                    do {
                        let dictionary: Dictionary<NSObject, AnyObject> = try NSJSONSerialization.JSONObjectWithData(directionsData!, options: NSJSONReadingOptions.MutableContainers) as! Dictionary<NSObject, AnyObject>
                        let status = dictionary["status"] as! String
                        
                        if status == "OK" {
                            self.selectedRoute = (dictionary["routes"] as! Array<Dictionary<NSObject, AnyObject>>)[0]
                            self.overviewPolyline = self.selectedRoute["overview_polyline"] as! Dictionary<NSObject, AnyObject>
                            let legs = self.selectedRoute["legs"] as! Array<Dictionary<NSObject, AnyObject>>
                            
                            let startLocationDictionary = legs[0]["start_location"] as! Dictionary<NSObject, AnyObject>
                            self.originCoordinate = CLLocationCoordinate2D(latitude: startLocationDictionary["lat"] as! Double, longitude: startLocationDictionary["lng"] as! Double)
                            let endLocationDictionary = legs[legs.count - 1]["end_location"] as! Dictionary<NSObject, AnyObject>
                            self.destinationCoordinate = CLLocationCoordinate2D(latitude: endLocationDictionary["lat"] as! Double, longitude: endLocationDictionary["lng"] as! Double)
                            self.originAddress = legs[0]["start_address"] as! String
                            self.destinationAddress = legs[legs.count - 1]["end_address"] as! String
                            self.calculateTotalDistanceAndDuration()
                            for leg in self.selectedRoute["legs"] as! Array<Dictionary<NSObject, AnyObject>> {
                                for step in leg["steps"] as! Array<Dictionary<NSObject, AnyObject>> {
                                    let lat = step["end_location"]!["lat"] as! Double
                                    let long = step["end_location"]!["lng"] as! Double
                                    let distance = step["distance"]!["value"] as! Double
                                    let coord = CLLocation(latitude: lat, longitude: long)
                                    let encodedString = step["html_instructions"] as! String
                                    let attributedOptions : [String: AnyObject] = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding]
                                    let attributedString = NSAttributedString(string: encodedString, attributes: attributedOptions)
                                    let directions = attributedString.string
                                    print(directions)
                                    let stepObject = Step(location: coord, direction: directions, distance: distance)
                                    self.steps.append(stepObject)
                                }
                            }
                            completionHandler(status: status, success: true)
                        } else {
                            completionHandler(status: status, success: false)
                            
                        }
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        completionHandler(status: "", success: false)
                    }
                        
                        
                })
                
            } else {
                completionHandler(status: "Destination is nil.", success: false)
            }
        } else {
            completionHandler(status: "Origin is nil", success: false)
        }
    }
    
    static func calculateTotalDistanceAndDuration() {
        let legs = self.selectedRoute["legs"] as! Array<Dictionary<NSObject, AnyObject>>
        totalDistanceInMeter = 0
        totalDurationInSeconds = 0
        for leg in legs {
            totalDistanceInMeter += (leg["distance"] as! Dictionary<NSObject, AnyObject>)["value"] as! UInt
            totalDurationInSeconds += (leg["duration"] as! Dictionary<NSObject, AnyObject>)["value"] as! UInt
        }
        var distanceInMiles: Double = Double(totalDistanceInMeter)/1609.34
        distanceInMiles = round(distanceInMiles * 100) / 100
        totalDistance = "Total Distance: \(distanceInMiles) Mi."
        let mins = totalDurationInSeconds/60
        let hours = mins/60
        let days = hours/24
        totalDuration = "Duration: \(days) days, \(hours%24) hr, \(mins%60) min"
    }
}