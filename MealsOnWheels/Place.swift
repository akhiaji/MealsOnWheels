//
//  Place.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 5/22/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import GoogleMaps


class Place {
    var name: String!
    var formattedAddress: String!
    var lat: Double!
    var long: Double!
    var coordinate: CLLocationCoordinate2D!
    
    init(name: String, formattedAddress: String, lat: Double, long: Double) {
        self.name = name
        self.formattedAddress = formattedAddress
        self.lat = lat
        self.long = long
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    init(place: GMSPlace) {
        self.name = place.name
        self.formattedAddress = place.formattedAddress
        self.coordinate = place.coordinate
        self.lat = coordinate.latitude
        self.long = coordinate.longitude
    }
    
    init(dict: NSDictionary) {
        self.name = dict["name"] as! String
        self.formattedAddress = dict["formattedAddress"] as! String
        self.lat = dict["lat"] as! Double
        self.long = dict["long"] as! Double
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    func toDict() -> NSDictionary {
        let dict = NSMutableDictionary()
        dict.setObject(name!, forKey: "name" as NSCopying)
        dict.setObject(formattedAddress!, forKey: "formattedAddress" as NSCopying)
        dict.setObject(lat!, forKey: "lat" as NSCopying)
        dict.setObject(long!, forKey: "long" as NSCopying)
        return dict
    }
    
    
}
