//
//  TheatersViewController.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 07/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit
import CoreLocation
import Kingfisher

class TheatersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate{
    
    //MARK: - Local properties
    
    var segmentedControl = HMSegmentedControl()
    var locationview = UIView()
    var tableViewTheaters = UITableView()
    var arrayTheatersList = NSMutableArray()
    var arrayCacheTheatreList = NSMutableArray()
    
    var locationManager = CLLocationManager()
    var locationDictionary = ["lat":0.0,"lon":0.0]
    
    var previousScrollViewvalue:CGFloat = 0.0
    
    //MARK: - Check and remove if necessary
    var navigRef : UINavigationController?
    var controlRef : SLPagingViewSwift?
    
    var isLocationFetched = Bool()
    
    //MARK: - ViewController life cycle methods
    
    override func viewWillAppear(animated: Bool) {
        self.tableViewTheaters.reloadData()
        print("view did will appear locationmanager \(self.locationManager)")
        
    }
    
          
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.view.backgroundColor = UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
//        
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "loginBackground")?.drawInRect(self.view.bounds)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        self.view.backgroundColor = UIColor.init(patternImage: image)
        
        self.view.backgroundColor = UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0)
        
        print("view did load locationmanager \(self.locationManager)")
        
        designSegmentedControl()
        designTableView()
        getValuesFromCoreData()
    }
    
    //MARK: - Design part
    
    func designSegmentedControl() {
        //Adding background image
        let width:CGFloat = self.view.frame.width
        let height:CGFloat = 44
        let xAxis:CGFloat = 0
        let yAxis:CGFloat = 0
        
        segmentedControl.sectionTitles = ["SORT UP", "NEAR BY"]
        segmentedControl.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        let attributes = [
            NSFontAttributeName : UIFont.boldSystemFontOfSize( 12.0),
            NSForegroundColorAttributeName : UIColor.whiteColor(), NSBackgroundColorAttributeName : UIColor.clearColor()]
        segmentedControl.selectedTitleTextAttributes = attributes
        segmentedControl.titleTextAttributes = attributes
        segmentedControl.tintColor = UIColor.whiteColor()
        segmentedControl.backgroundColor = UIColor.init(colorLiteralRed: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0)
        segmentedControl.selectionIndicatorColor = UIColor(red: 27/255, green: 207/255, blue: 240/255, alpha: 1.0)
        segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        segmentedControl.selectionIndicatorHeight = 2;
        self.view.addSubview(segmentedControl)
        
        segmentedControl.indexChangeBlock = { (index) in
            if index == 0{
                print("Show A-Z")
                
                let arySorted = self.arrayTheatersList.sort{
                    (($0 as! Dictionary<String, AnyObject>)["Theater_Name"] as? String) < (($1 as! Dictionary<String, AnyObject>)["Theater_Name"] as? String)
                }
                
                self.arrayTheatersList.removeAllObjects()
                self.arrayTheatersList.addObjectsFromArray(arySorted)
                
                self.tableViewTheaters.reloadData()
            }
            else if index == 1{
                print("Show NEAR BY")
                
//                locationManager.delegate = self
//                locationManager.distanceFilter = kCLDistanceFilterNone
//                locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//                locationManager.startUpdatingLocation()
//                locationManager.requestAlwaysAuthorization()
                
                if self.isLocationFetched{
                    
                    let arySorted = self.arrayCacheTheatreList.sort{
                        (($0 as! Dictionary<String, AnyObject>)["distance"] as? CLLocationDistance) > (($1 as! Dictionary<String, AnyObject>)["distance"] as? CLLocationDistance)
                    }
                    self.arrayTheatersList.removeAllObjects()
                    self.arrayTheatersList.addObjectsFromArray(arySorted)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableViewTheaters.reloadData()
                    }
                }
                else{
                    
                    //Donot comment this line, else the table data will not be loaded
                    self.locationManager.delegate = self
                    self.locationManager.distanceFilter = kCLDistanceFilterNone
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    self.locationManager.startUpdatingLocation()
                    self.locationManager.requestWhenInUseAuthorization()
                }
            }
        }
    }
    
    func designTableView() {
        
        //Adding background image
        let width:CGFloat = self.view.frame.width
        let height:CGFloat = self.view.frame.size.height-locationview.frame.size.height-segmentedControl.frame.size.height-64
        let xAxis:CGFloat = 0
        let yAxis:CGFloat = segmentedControl.frame.origin.y+segmentedControl.frame.size.height+10
        
        tableViewTheaters = UITableView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height), style: UITableViewStyle.Plain)
        tableViewTheaters.tag = 1
        tableViewTheaters.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableViewTheaters.allowsMultipleSelectionDuringEditing = false
        tableViewTheaters.delegate = self
        tableViewTheaters.dataSource = self
        tableViewTheaters.backgroundColor = UIColor.clearColor()//UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
        tableViewTheaters.separatorStyle = UITableViewCellSeparatorStyle.None
        tableViewTheaters.showsVerticalScrollIndicator = false
        tableViewTheaters.showsHorizontalScrollIndicator = false
        tableViewTheaters.rowHeight = 50;
        self.view.addSubview(tableViewTheaters)
    }
    
    //MARK: - Table view delegate and datasource methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "TheatersTableViewCell"
        var cell: TheatersTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? TheatersTableViewCell
        if cell == nil{
            let rectFrame = tableView.rectForRowAtIndexPath(indexPath)
            cell = TheatersTableViewCell(style: .Default, reuseIdentifier: identifier, frameCell: rectFrame)
        }
        
        
        let dictItem = arrayTheatersList[(indexPath as NSIndexPath).row] as! NSDictionary
        
        //print("Cell dictionary: \(dictItem)")
        
        //cell.setLblTitleName(dictItem.valueForKey("item") as! String)
        
//        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: URL!) -> Void in
//            print(self)
//        }
        
        var strURLCode = "\(dictItem.valueForKey( "Theater_Pic"))"
//        if strURLCode!.containsString("http"){
//            strURLCode! = ""
//        }
//        
//        var strURLtoAppend:String = String(format: "http://img.youtube.com/vi/%@/hqdefault.jpg", strURLCode!)
        if strURLCode.containsString("Optional("){
            strURLCode = strURLCode.stringByReplacingOccurrencesOfString("Optional(", withString: "")
        }
        if strURLCode.containsString(")"){
            strURLCode = strURLCode.stringByReplacingOccurrencesOfString(")", withString: "")
        }
        
        if (indexPath as NSIndexPath).row%2 == 0{
            cell.backgroundColor = UIColor.init(colorLiteralRed: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0)//UIColor.init(colorLiteralRed: 17/255.0, green: 18/255.0, blue: 21/255.0, alpha: 1.0)
        }
        else{
            cell.backgroundColor = UIColor.init(colorLiteralRed: 12/255.0, green: 13/255.0, blue: 15/255.0, alpha: 1.0)
        }
        
        
        let escapedAddress = strURLCode.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        let url = NSURL(string: escapedAddress!)
        //        cell.imgViewMovies.sd_setImageWithURL(url, completed: block)
        let imgPlaceholder = UIImage(named: "placeholder_movie")
        cell.imgViewMovies.image = imgPlaceholder
        
        //ImagedNeeded
        cell.imgViewMovies.kf_setImageWithURL(url, placeholderImage: imgPlaceholder, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        
        //http://img.youtube.com/vi/<insert-youtube-image-id-here>/1.jpg
        
        cell.lblTitle.text = dictItem.valueForKey( "Theater_Name") as? String
        
        cell.lblAddress.text = dictItem.valueForKey( "Address") as? String
        
        return cell
    }
    
    
    
    // number of rows in table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTheatersList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let dictValue = arrayTheatersList[(indexPath as NSIndexPath).row] as! NSDictionary
        
        print("Theater tapped: \(dictValue)")
        
        let str_TheatreID = String(dictValue.valueForKey("Theater_ID")!)
        let str_locationID = String(dictValue.valueForKey("Location")!)
        
        self.getBookingDetailsForTheatre(str_TheatreID, locationID: str_locationID)
        
        
        
        
//        if aryBookingsList_?.count != 0{
//            
//            let dictItem = arrayTheatersList[(indexPath as NSIndexPath).row] as! NSDictionary
//            
//            let theatresDetailedViewController = TheatreDetailedVC(justInit: NSDictionary())
//            theatresDetailedViewController.navigCRefe = self.navigRef
//            theatresDetailedViewController.controlCRefe = self.controlRef
//            theatresDetailedViewController.arrayBookingsList = aryBookingsList_!
//            theatresDetailedViewController.theaterNameTapped = (dictItem.valueForKey( "vname") as? String)! as NSString
//            navigRef!.pushViewController(theatresDetailedViewController, animated: true)
//            
//        }
//        else{
//            let alertView_ = UIAlertView(title: "City Movies", message: "No bookings found for this theatre", delegate: nil, cancelButtonTitle: "Ok")
//            alertView_.show()
//        }
    }
    
    
    //MARK: - TableView scrollview delegates
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.isKindOfClass(  UITableView.self){
            
            let topYAxis:CGFloat = scrollView.contentOffset.y + scrollView.contentInset.top
            
            if previousScrollViewvalue > topYAxis+150{
                
                UIView.animateWithDuration(0.3, animations: {
                    self.segmentedControl.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
                    
                    self.tableViewTheaters.frame = CGRect(x: 0, y: self.segmentedControl.frame.size.height+self.segmentedControl.frame.origin.y+10, width: self.view.frame.width, height: self.view.frame.size.height-self.segmentedControl.frame.size.height-74)
                });
            }
            
            if topYAxis > 100 && previousScrollViewvalue < topYAxis-150{
                UIView.animateWithDuration( 0.3, animations: {
                    self.segmentedControl.frame = CGRect(x: 0, y: -44, width: self.view.frame.width, height: 44)
                    
                    self.tableViewTheaters.frame = CGRect(x: 0, y: self.segmentedControl.frame.size.height+self.segmentedControl.frame.origin.y+10, width: self.view.frame.width, height: self.view.frame.size.height-self.segmentedControl.frame.size.height-74+44)
                });
            }
            
            if(topYAxis <= 20){
                UIView.animateWithDuration( 0.3, animations: {
                    self.segmentedControl.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
                    
                    self.tableViewTheaters.frame = CGRect(x: 0, y: self.segmentedControl.frame.size.height+self.segmentedControl.frame.origin.y+10, width: self.view.frame.width, height: self.view.frame.size.height-self.segmentedControl.frame.size.height-74)
                });
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let topYAxis:CGFloat = scrollView.contentOffset.y + scrollView.contentInset.top
        previousScrollViewvalue = topYAxis
    }
  
    
    
    //MARK: - Services part
    func getTheatersList() {
        print("Getting theaters list")
 
        let url_ = NSURL(string: "http://citymoviesapi.bananaapps.co.in/api/Theater/TheaterDetails")
        let request = NSURLRequest(URL: url_!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            // notice that I can omit the types of data, response and error
            // your code
            
            
            if response != nil{
                
                
                if response != nil{
                    
                    let httpResponse = response as! NSHTTPURLResponse
                    let statusCode = httpResponse.statusCode
                    
                    if (statusCode == 200) {
                        
                        do {
                            if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                                // process "json" as a dictionary
                                //                        print("\(json)")
                                
                                let json_array_theatres = json.valueForKey("TheaterDetails")
                                
                                if let json = json_array_theatres as? NSArray {
                                    
                                    self.arrayCacheTheatreList.removeAllObjects()
                                    
                                    for item_ in json {
                                        let dictMutable = NSMutableDictionary()
                                        
                                        let obj = item_ as! NSDictionary
                                        for (key, value) in obj {
                                            dictMutable.setValue(value, forKey: key as! String)
                                        }
                                        
                                        self.arrayCacheTheatreList.addObject(dictMutable)
                                    }
                                }
                                
                                print("Array theatres: \(self.arrayCacheTheatreList)")
                                
                                let arySorted = self.arrayCacheTheatreList.sort{
                                    (($0 as! Dictionary<String, AnyObject>)["Location_Name"] as? String) < (($1 as! Dictionary<String, AnyObject>)["Location_Name"] as? String)
                                }
                                self.arrayTheatersList.removeAllObjects()
                                self.arrayTheatersList.addObjectsFromArray(arySorted)
                                
                                dispatch_async(dispatch_get_main_queue()) {
                                    
                                    //                            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                                    //                            let theatresList = appDelegate.getValues("Theaters")
                                    //                            if theatresList.count > 0{
                                    //                                appDelegate.deleteEntity("Theaters")
                                    //                            }
                                    //
                                    //
                                    //                            for movie in self.arrayTheatersList{
                                    //                                appDelegate.setValuesToEntity("Theaters", withDictionary: movie as! NSDictionary)
                                    //                            }
                                    
                                    self.tableViewTheaters.reloadData()
                                }
                                
                                print("Got all the theater array list")
                                dispatch_async(dispatch_get_main_queue()) {
                                    print("Made a theater reload request: In side main thread")
                                    self.tableViewTheaters.reloadData()
                                }
                                
                                
                                
                                
                            } else if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
                                // process "json" as an array
                                
                                
                                
                            } else {
                                //                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                                //                        print("Error could not parse theater JSON string: \(jsonStr)")
                                print("Error could not parse movies JSON string:")
                            }
                            
                        } catch {
                            print("error serializing theater JSON: \(error)")
                        }
                    }
                }
                else{
                    print("failed to fetch theatres list")
                }
                
            }
            
            
        });
        
        // do whatever you need with the task e.g. run
        task.resume()
        
    }
    
    
    //MARK: - Get values from coredata
    func getValuesFromCoreData() {
        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        let aryEntityValues:NSArray = appDelegate.getValues("Theaters")
//        
//        if aryEntityValues.count > 0{
//            
//            for dicti in aryEntityValues{
//                
//                let theaters_obj:Theaters = dicti as! Theaters
//                
//                let movies_DictObj = NSMutableDictionary()
//                movies_DictObj.setValue(theaters_obj.id, forKey: "Theater_ID")
//                movies_DictObj.setValue(theaters_obj.address, forKey: "Address")
//                movies_DictObj.setValue(theaters_obj.location, forKey: "Location")
//                movies_DictObj.setValue(theaters_obj.vlat, forKey: "Latitude")
//                movies_DictObj.setValue(theaters_obj.vlong, forKey: "Longitude")
//                movies_DictObj.setValue(theaters_obj.vcode, forKey: "Theater_Pic")
//                movies_DictObj.setValue(theaters_obj.vname, forKey: "Theater_Name")
//                
//                //NSDictionary *myDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:myData];
//                
////                let aryMovieImageList = NSKeyedUnarchiver.unarchiveObjectWithData(theaters_obj.theaterBookingDetails! as NSData) as! NSArray
////                if aryMovieImageList.count > 0 {
////                    movies_DictObj.setObject(aryMovieImageList, forKey: "TheaterBookingDetails" as NSCopying)
////                }
////                else{
////                    movies_DictObj.setObject(NSArray(), forKey: "TheaterBookingDetails" as NSCopying)
////                }
//                
//                
//                
//                self.arrayCacheTheatreList.addObject(movies_DictObj)
//                self.arrayTheatersList.addObject(movies_DictObj)
//            }
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                print("Made a theatres reload request: In side main thread. Fetching from coredata")
//                self.tableViewTheaters.reloadData()
//                
//                self.getTheatersList()
//            }
//        }
//        else{
            getTheatersList()
//        }
    }
    
    //MARK: - Getting booking details
    func getBookingDetailsForTheatre(movieID: String, locationID: String) {
        print("MovieID: \(movieID) LocationID: \(locationID)")
        
        //Adding activity view to self.view
        if ARSLineProgress.shown { return }
        ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.userInteractionEnabled = false
        
        
        let url_ = NSURL(string: "http://citymoviesapi.bananaapps.co.in/api/MovieBooking/MovieBooking")
        
        let request = NSMutableURLRequest(URL: url_!)
        request.HTTPMethod = "POST"
        
        let json = [ "Mov_ID":movieID , "Location_ID": locationID]
        
        do {
            let jsonResult = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            request.HTTPBody = jsonResult
            print("dictionar \(jsonResult)")
        } catch let error as NSError {
            print("error in constructing dictionar: \(error.localizedDescription)")
        }
        
        
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            // notice that I can omit the types of data, response and error
            // your code
            
            if response != nil{
                
                let httpResponse = response as! NSHTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                if (statusCode == 200) {
                    
                    do {
                        
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                            // process "json" as a dictionary
                            print("\(json)")
                            
                            let arrayMovieBookingDetails = json.valueForKey("MovieBooking") as! NSArray
                            
                            if arrayMovieBookingDetails.count != 0{
                                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                                
                                if let bookingVC = storyBoard.instantiateViewControllerWithIdentifier("BookVCStoryboardID") as? BookVC {
                                    bookingVC.navigRef = self.navigRef
                                    bookingVC.arrayMovieBookingList = arrayMovieBookingDetails
                                    dispatch_async(dispatch_get_main_queue()) {
                                        self.navigRef?.presentViewController(bookingVC, animated: true, completion: nil) //pushViewController(bookingVC, animated: true)
                                    }
                                }
                            }
                            else{
                                dispatch_async(dispatch_get_main_queue()) {
                                    let alertView_ = UIAlertView(title: "City Movies", message: "No bookings found for this movie.", delegate: nil, cancelButtonTitle: "Ok")
                                    alertView_.show()
                                }
                            }
                            
                            
                        } else if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
                            // process "json" as an array
                            print("\(json)")
                            
                        } else {
                            print("Error could not parse movies JSON string:")
                            dispatch_async(dispatch_get_main_queue()) {
                                let alertView_ = UIAlertView(title: "City Movies", message: "No bookings found for this movie.", delegate: nil, cancelButtonTitle: "Ok")
                                alertView_.show()
                            }
                        }
                        
                    } catch {
                        print("error serializing movies JSON: \(error)")
                        dispatch_async(dispatch_get_main_queue()) {
                            let alertView_ = UIAlertView(title: "City Movies", message: "No bookings found for this movie.", delegate: nil, cancelButtonTitle: "Ok")
                            alertView_.show()
                        }
                    }
                }
                else{
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        let alertView_ = UIAlertView(title: "City Movies", message: "No bookings found for this movie.", delegate: nil, cancelButtonTitle: "Ok")
                        alertView_.show()
                    }
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    appDelegate.window?.userInteractionEnabled = true
                    //                self.view.userInteractionEnabled = true
                    ARSLineProgress.hideWithCompletionBlock({ () -> Void in
                        print("Hidden with completion block")
                    })
                }
                
            }
            
        });
        
        
        // do whatever you need with the task e.g. run
        task.resume()
        
    }

    

    //MARK: - Location Manager Delegate Methods
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Some error \(error) while retreving location")
    }
    
    
//    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
//        locationDictionary["lat"] = newLocation.coordinate.latitude
//        locationDictionary["lon"] = newLocation.coordinate.longitude
//        
//        for (index , k) in self.arrayCacheTheatreList.enumerate() {
//            let location = CLLocation(latitude: (k["Latitude"] as? CLLocationDegrees)!, longitude: (k["Longitude"] as? CLLocationDegrees)!)
//        
//            let distance = location.distanceFromLocation(newLocation)
//            (self.arrayCacheTheatreList[index] as! NSDictionary).setValue(distance, forKey: "distance")
//        }
//        
//        
//        let arySorted = self.arrayCacheTheatreList.sort{
//            (($0 as! Dictionary<String, AnyObject>)["distance"] as? CLLocationDistance) < (($1 as! Dictionary<String, AnyObject>)["distance"] as? CLLocationDistance)
//        }
//        self.arrayTheatersList.removeAllObjects()
//        self.arrayTheatersList.addObjectsFromArray(arySorted)
//        print("Got all the theater array list")
//        print("Made a reload theater request: out of main thread")
//        
//        dispatch_async(dispatch_get_main_queue()) {
//            print("Made a theater reload request: In side main thread")
//            print("sffgdgdhdfhdfhfh \(self.arrayTheatersList)")
//            self.tableViewTheaters.reloadData()
//        }
//    }
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !isLocationFetched{
            isLocationFetched = true
            
            print("Didupdate to location: \(locations)")
            
            var currentLocation = CLLocation()
            currentLocation = locations[0]
            
            locationDictionary["lat"] = currentLocation.coordinate.latitude
            locationDictionary["lon"] = currentLocation.coordinate.longitude
            
            for (index , k) in self.arrayCacheTheatreList.enumerate() {
                
                let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double((k["Latitude"] as! NSString).doubleValue), longitude: Double((k["Longitude"] as! NSString).doubleValue))
                
                //let locationObj: CLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                //self.arrayLatAndLongs.addObject(locationObj)
                //
                //let location = CLLocation(latitude: (k["Latitude"] as? CLLocationDegrees)!, longitude: (k["Longitude"] as? CLLocationDegrees)!)
                
                let locationObj: CLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                
                let distance = locationObj.distanceFromLocation(currentLocation)
                (self.arrayCacheTheatreList[index] as! NSDictionary).setValue(distance, forKey: "distance")
            }
            
            
            let arySorted = self.arrayCacheTheatreList.sort{
                (($0 as! Dictionary<String, AnyObject>)["distance"] as? CLLocationDistance) < (($1 as! Dictionary<String, AnyObject>)["distance"] as? CLLocationDistance)
            }
            self.arrayTheatersList.removeAllObjects()
            self.arrayTheatersList.addObjectsFromArray(arySorted)
            
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableViewTheaters.reloadData()
            }
            
        }
    }
    
 
    
}
