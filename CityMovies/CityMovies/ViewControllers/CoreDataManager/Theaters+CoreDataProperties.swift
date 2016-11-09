//
//  Theaters+CoreDataProperties.swift
//  
//
//  Created by Goutham Devaraju on 08/08/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Theaters {

    @NSManaged var theaterBookingDetails: NSData?
    @NSManaged var address: String?
    @NSManaged var id: String?
    @NSManaged var location: String?
    @NSManaged var vcode: String?
    @NSManaged var vlat: String?
    @NSManaged var vlong: String?
    @NSManaged var vname: String?

}
