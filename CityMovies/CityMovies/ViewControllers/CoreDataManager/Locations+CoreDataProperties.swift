//
//  Locations+CoreDataProperties.swift
//  
//
//  Created by Goutham Devaraju on 31/08/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Locations {

    @NSManaged var city: String?
    @NSManaged var latitude: String?
    @NSManaged var longitude: String?
    @NSManaged var lid: NSNumber?
    @NSManaged var state: String?

}
