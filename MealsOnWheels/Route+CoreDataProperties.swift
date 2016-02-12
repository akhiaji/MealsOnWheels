//
//  Route+CoreDataProperties.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 2/11/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Route {

    @NSManaged var origin: String?
    @NSManaged var originAddress: String?
    @NSManaged var destination: String?
    @NSManaged var destinationAddress: String?
    @NSManaged var waypoints: String?
    @NSManaged var waypointAdresses: String?

}
