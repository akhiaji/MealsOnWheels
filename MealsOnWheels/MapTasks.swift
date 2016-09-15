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
    static let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
    
    static var lookupAddressResults: Dictionary<NSObject, AnyObject>!
    
    static var fetchedFormattedAddress: String!
    
    static var fetchedAddressLongitude: Double!
    
    static var fetchedAddressLatitude: Double!
    
    static let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"
    
    static var selectedRoute: Dictionary<NSObject, AnyObject>!
    
    static var overviewPolyline: Dictionary<NSObject, AnyObject>!
    
    static var customPath: GMSMutablePath!
    
    static var originCoordinate: CLLocationCoordinate2D!
    
    static var destinationCoordinate: CLLocationCoordinate2D!
    
    static var originAddress: String!
    
    static var destinationAddress: String!
    
    static var totalDistanceInMeter: UInt = 0
    
    static var totalDistance: String!
    
    static var totalDurationInSeconds: UInt = 0
    
    static var totalDuration: String!
    
    static var steps: Array<Step>! = Array<Step>()
    
    static var locationCoords: Array<CLLocationCoordinate2D>!
    
    static var markerLoc = Array<CLLocationCoordinate2D>()
    
    static var order = Array<Int>()
    
    static var waypointsArray = Array<Waypoint>()
    
    static var enforceOrder: Bool = false
    
    
    override init() {
        super.init()
    }
    
    
    
    static func getDirections(origin: String!, destination: String!, waypointsTemp: Array<String>!, travelMode: AnyObject!, completionHandler: ((status: String, success: Bool) -> Void)) {
        
        
//        var routeString = "comgooglemaps-x-callback://"
//        routeString += "?daddr" + destination
//        routeString += "&x-success=MOWapp://?resume=true&x-source=MOW";
//        routeString = routeString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        let directionsURL = NSURL(fileURLWithPath:routeString);
//        UIApplication.sharedApplication().openURL(directionsURL)
        
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
            UIApplication.sharedApplication().openURL(NSURL(string:
                "comgooglemaps://?center=40.765819,-73.975866&zoom=14&views=traffic")!)
        } else {
            print("Can't use comgooglemaps://");
        }
        
        
        
        
        let waypoints = NSMutableArray(array: waypointsTemp)
        steps.removeAll()
        if(customPath != nil) {
            customPath.removeAllCoordinates()
        }
        
        if let originLocation = origin {
            if let destinationLocation = destination {
                var directionsURLString = baseURLDirections + "origin=" + originLocation + "&destination=" + destinationLocation
                if waypoints.count > 0  {
                    if enforceOrder == true {
                        directionsURLString += "&waypoints=optimize:false"
                    } else {
                        directionsURLString += "&waypoints=optimize:true"
                    }
                    for waypoint in waypoints {
                        directionsURLString += "|"+(waypoint as! String)
                    }
                }
                if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
                    UIApplication.sharedApplication().openURL(NSURL(string:
                        "comgooglemaps://?center=40.765819,-73.975866&zoom=14&views=traffic")!)
                } else {
                    print("Can't use comgooglemaps://");
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
                            self.order = self.selectedRoute["waypoint_order"] as! Array<Int>
                            let startLocationDictionary = legs[0]["start_location"] as! Dictionary<NSObject, AnyObject>
                            self.originCoordinate = CLLocationCoordinate2D(latitude: startLocationDictionary["lat"] as! Double, longitude: startLocationDictionary["lng"] as! Double)
                            let endLocationDictionary = legs[legs.count - 1]["end_location"] as! Dictionary<NSObject, AnyObject>
                            self.destinationCoordinate = CLLocationCoordinate2D(latitude: endLocationDictionary["lat"] as! Double, longitude: endLocationDictionary["lng"] as! Double)
                            self.originAddress = legs[0]["start_address"] as! String
                            self.destinationAddress = legs[legs.count - 1]["end_address"] as! String
                            self.calculateTotalDistanceAndDuration()
                            let route = overviewPolyline["points"] as! String
                            let path: GMSPath = GMSPath(fromEncodedPath: route)!
                            customPath = GMSMutablePath(path: path)
                            customPath.removeAllCoordinates()
                            waypoints.addObject(destination)
                            for leg in self.selectedRoute["legs"] as! Array<Dictionary<NSObject, AnyObject>> {
                                for step in leg["steps"] as! Array<Dictionary<NSObject, AnyObject>> {
                                    let lat = step["end_location"]!["lat"] as! Double
                                    let long = step["end_location"]!["lng"] as! Double
                                    let distance = step["distance"]!["value"] as! Double
                                    let path = step["polyline"]
                                    let epath = path!["points"] as! String
                                    let coord = CLLocation(latitude: lat, longitude: long)
                                    customPath.addCoordinate(coord.coordinate)
                                    let encodedString = step["html_instructions"] as! String
                                    let attributedOptions : [String: AnyObject] = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding]
                                    let attributedString = NSAttributedString(string: encodedString, attributes: attributedOptions)
                                    let directions = attributedString.string
                                    let stepObject = Step(location: coord, direction: directions, distance: distance, path: GMSPath(fromEncodedPath: epath)!, waypoint: false)
                                    self.steps.append(stepObject)
                                }
                                steps[steps.count - 1].waypoint = true
                            }
                            for i in self.order{
                                let waypointsCopy = NSMutableArray()
                                waypointsCopy.addObject(waypointsArray[i])
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
    
    static func sendToEnd(waypoint: Waypoint?, completionHandler: ((status: String, success: Bool) -> Void)){
        var first = waypointsArray.removeFirst()
        if waypoint != nil{
            first = waypoint as Waypoint!
        }
        waypointsArray.append(first)
        var temp = Array<String>()
        for waypoint in waypointsArray {
            temp.append(waypoint.address)
        }

        enforceOrder = true
        getDirections(originAddress, destination: destinationAddress, waypointsTemp: temp, travelMode: nil, completionHandler: completionHandler)

    }
}