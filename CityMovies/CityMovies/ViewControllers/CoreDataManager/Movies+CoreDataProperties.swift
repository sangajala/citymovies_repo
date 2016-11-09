//
//  Movies+CoreDataProperties.swift
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

extension Movies {

    @NSManaged var actors: String?
    @NSManaged var banner: String?
    @NSManaged var censor: String?
    @NSManaged var description_: String?
    @NSManaged var director: String?
    @NSManaged var id: String?
    @NSManaged var iscommingsoon: String?
    @NSManaged var language: String?
    @NSManaged var length: String?
    @NSManaged var mainimage: String?
    @NSManaged var mdirector: String?
    @NSManaged var mid: String?
    @NSManaged var mname: String?
    @NSManaged var movieImagesList: NSData?
    @NSManaged var movieInVenueList: NSData?
    @NSManaged var movieType: String?
    @NSManaged var producer: String?
    @NSManaged var releasedate: String?
    @NSManaged var status: String?
    @NSManaged var storyLine: String?
    @NSManaged var trailArUrl: String?
    @NSManaged var voice: String?
    @NSManaged var writer: String?
    @NSManaged var rating: String?
    @NSManaged var movieVideosList: NSData?
    @NSManaged var movieArtists: NSData?
    @NSManaged var movierating: NSData?

}
