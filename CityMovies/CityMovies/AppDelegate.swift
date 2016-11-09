//
//  AppDelegate.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 03/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        NSThread.sleepForTimeInterval(1.0)
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        FBSDKAppEvents.activateApp()
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    //MARK: - Core Data manager
    func setValuesToEntity(withName:String, withDictionary:NSDictionary) {
        
        if withName == "Movies"{
            
            let movies:Movies = NSEntityDescription.insertNewObjectForEntityForName("Movies", inManagedObjectContext: managedObjectContext) as! Movies
            
//            print("Dict recevied: \(withDictionary)")
            
//            let idOfMovie:String = String(format: withDictionary.valueForKey( "id")! as! String)
            let idOfMovie = String(withDictionary.valueForKey( "Mov_ID")!)
            let ratingOfMovie = String(withDictionary.valueForKey( "AvgRating")!)
            let length = String(withDictionary.valueForKey( "Duration")!)
            
            movies.actors = withDictionary.valueForKey( "Actors") as? String
            movies.banner = withDictionary.valueForKey( "Banner") as? String
            movies.censor = withDictionary.valueForKey( "Censor") as? String
            movies.description_ = withDictionary.valueForKey( "Description") as? String
            movies.director = ""//withDictionary.valueForKey( "director") as? String
            movies.id = idOfMovie as String
            movies.iscommingsoon = withDictionary.valueForKey( "iscommingsoon") as? String
            movies.language = withDictionary.valueForKey( "Language") as? String
            movies.length = length as String
            movies.mainimage = withDictionary.valueForKey( "Mov_Image") as? String
            movies.mdirector = ""//withDictionary.valueForKey( "mdirector") as? String
            movies.mid = withDictionary.valueForKey( "Mov_ID") as? String
            movies.mname = withDictionary.valueForKey( "Mov_Name") as? String
            movies.movieType = withDictionary.valueForKey( "Movie_Type_Details") as? String
            movies.producer = ""//withDictionary.valueForKey( "producer") as? String
            movies.rating = ratingOfMovie as String
            movies.releasedate = withDictionary.valueForKey( "Release_Date") as? String
            movies.status = withDictionary.valueForKey( "Status") as? String
            movies.storyLine = withDictionary.valueForKey( "Story_Line") as? String
            let aryMovieVideos = withDictionary.valueForKey( "MovieVideos") as? NSArray
            
            let dictMovieVideos = aryMovieVideos![0] as? NSDictionary
            movies.trailArUrl = dictMovieVideos!.valueForKey( "URL") as? String
            
            movies.voice = ""//withDictionary.valueForKey( "voice") as? String
            movies.writer = ""//withDictionary.valueForKey( "writer") as? String
            movies.movieImagesList = NSKeyedArchiver.archivedDataWithRootObject(withDictionary.valueForKey( "MovieImages")!)
            movies.movieVideosList = NSKeyedArchiver.archivedDataWithRootObject(withDictionary.valueForKey( "MovieVideos")!)
            movies.movieArtists = NSKeyedArchiver.archivedDataWithRootObject(withDictionary.valueForKey( "MovieArtists")!)
            movies.movierating = NSKeyedArchiver.archivedDataWithRootObject(withDictionary.valueForKey("Movierating")!)
            
            //if managedObjectContext.hasChanges {
             //   do {
             //       try managedObjectContext.save()
             //   } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
              //      let nserror = error as NSError
             //       NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
              //      abort()
              //  }
           // }
        }
        
        
        if withName == "Theaters"{
            
//            let theaters:Theaters = NSEntityDescription.insertNewObjectForEntityForName("Theaters", inManagedObjectContext: managedObjectContext) as! Theaters
//            
//            print("Dict recevied: \(withDictionary)")
//            
//            let idOfTheatre = String(withDictionary.valueForKey( "Theater_ID")!)
//            
////            let idOfTheatre:String = String(format: withDictionary.valueForKey( "id")! as! String)
//            let locationOfTheatre = String(withDictionary.valueForKey( "Location")!)
//            let vlatOfTheatre = String(withDictionary.valueForKey( "Latitude")!)
//            let vlongOfTheatre = String(withDictionary.valueForKey( "Longitude")!)
//            
////            theaters.theaterBookingDetails = NSKeyedArchiver.archivedDataWithRootObject(withDictionary.valueForKey( "TheaterBookingDetails")!)
//            theaters.address = withDictionary.valueForKey( "Address") as? String
//            theaters.id = idOfTheatre as String
//            theaters.location = locationOfTheatre as String
//            theaters.vcode = withDictionary.valueForKey( "Theater_Pic") as? String
//            theaters.vlat = vlatOfTheatre
//            theaters.vlong = vlongOfTheatre
//            theaters.vname = withDictionary.valueForKey( "Theater_Name") as? String
            
            //if managedObjectContext.hasChanges {
              //  do {
                //    try managedObjectContext.save()
                //} catch {
                  //  // Replace this implementation with code to handle the error appropriately.
                   // // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, //although it may be useful during development.
                    //let nserror = error as NSError
                    //NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    //abort()
                //}
            //}
        }
        
        
        if withName == "Locations"{
            
            let locations_:Locations = NSEntityDescription.insertNewObjectForEntityForName( "Locations", inManagedObjectContext: managedObjectContext) as! Locations
            
            locations_.city = withDictionary.valueForKey( "Location_Name") as? String
            locations_.latitude = withDictionary.valueForKey( "Latitude") as? String
            locations_.longitude = withDictionary.valueForKey( "Longitude") as? String
            locations_.lid = withDictionary.valueForKey( "Location_ID") as? NSNumber
            locations_.state = withDictionary.valueForKey( "State") as? String
            
            
        }
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
        
    }

    func getValues(withEntityName:String) -> NSArray {
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName(withEntityName, inManagedObjectContext: managedObjectContext)
        let aryValues:NSArray
        do {
            aryValues = try managedObjectContext.executeFetchRequest(fetchRequest)
            return aryValues
            // success ...
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
            return NSArray()
        }
    }
    
    
    func deleteEntity(withEntityName:String) {
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName(withEntityName, inManagedObjectContext: managedObjectContext)
        let aryValues:NSArray
        do {
            aryValues = try managedObjectContext.executeFetchRequest(fetchRequest)
            for managedObj in aryValues {
                managedObjectContext.deleteObject(managedObj as! NSManagedObject)
            }
            // success ...
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
            
        }
    }
    
    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.kandg.Dog_Parenting" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("CityMovies", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("CityMovies.sqlite")
        
        print("Store location: \(url)")
        
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

