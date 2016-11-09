//
//  MovieViewController.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 17/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit
import Kingfisher
//import CoreLocation


class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var segmentedControl = HMSegmentedControl()
    var tableViewMovies = UITableView()
    var arrayMoviesList = NSMutableArray()
    var arrayCacheMoviesList = NSMutableArray()
    
    //MARK: - Check and remove if necessary
    var navigRef : UINavigationController?
    var controlRef : SLPagingViewSwift?
    
//    var locationManager = CLLocationManager()
//    var locationDictionary = ["lat":0.0,"lon":0.0]
//    var isLocationReceived = Bool()
    
    var previousScrollViewvalue:CGFloat = 0.0
    
    
    //MARK: - View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("navigation controller is \(super.navigationController)")
        
        //For scrollView logic
        previousScrollViewvalue = 20
        
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "loginBackground")?.drawInRect(self.view.bounds)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(scrolledToPageZero), name: "ScrolledToPageZero", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(scrolledToPageMovies), name: "ScrolledToPageMovies", object: nil)
        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(scrolledToPageZero),
//            name: NSNotification.Name(rawValue: "ScrolledToPageZero"),
//            object: nil)
        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(scrolledToPageMovies),
//            name: NSNotification.Name(rawValue: "ScrolledToPageMovies"),
//            object: nil)
        
        designSegmentedControl()
        designTableView()
        
        getValuesFromCoreData()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.sendSubviewToBack(tableViewMovies)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        //        self.navigationController?.navigationBarHidden = false
        
        
        var width:CGFloat = self.view.frame.width
        var height:CGFloat = 44
        var xAxis:CGFloat = 0
        var yAxis:CGFloat = 64
        segmentedControl.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        
        
        width = self.view.frame.width
        height = self.view.frame.size.height-segmentedControl.frame.size.height-64
        xAxis = 0
        yAxis = segmentedControl.frame.origin.y+segmentedControl.frame.size.height
        tableViewMovies.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        
        self.view.sendSubviewToBack(tableViewMovies)
        self.view.bringSubviewToFront(segmentedControl)
    }
    
    func designSegmentedControl() {
        //Adding background image
        let width:CGFloat = self.view.frame.width
        let height:CGFloat = 44
        let xAxis:CGFloat = 0
        let yAxis:CGFloat = 0
        
        //        let width:CGFloat = self.view.frame.width
        //        let height:CGFloat = 44
        //        let xAxis:CGFloat = 0
        //        let yAxis:CGFloat = 64
        
        segmentedControl.sectionTitles = ["LATEST", "RATING"]
        segmentedControl.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        //UIColor(red: 27/255, green: 207/255, blue: 240/255, alpha: 1.0)
        let attributes = [
            NSFontAttributeName : UIFont.boldSystemFontOfSize(12.0),
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
                print("Show LATEST")
                
                let arySorted = self.arrayCacheMoviesList.sort{
                    (($0 as! Dictionary<String, AnyObject>)["Release_Date"] as? String) > (($1 as! Dictionary<String, AnyObject>)["Release_Date"] as? String)
                }
                
                self.arrayMoviesList.removeAllObjects()
                self.arrayMoviesList.addObjectsFromArray(arySorted)
                
                print("Arry sorted: \(self.arrayMoviesList)")
                
                self.tableViewMovies.reloadData()
            }
            else{
                print("Rating")
                //Donot comment this line, else the table data will not be loaded
                
                let arySorted = self.arrayCacheMoviesList.sort{
                    (($0 as! Dictionary<String, AnyObject>)["AvgRating"] as? Int) > (($1 as! Dictionary<String, AnyObject>)["AvgRating"] as? Int)
                }
                
                self.arrayMoviesList.removeAllObjects()
                self.arrayMoviesList.addObjectsFromArray(arySorted)
                
                print("Arry sorted: \(self.arrayMoviesList)")
                
                self.tableViewMovies.reloadData()
            }
        }
    }
    
    func designTableView() {
        
        //Adding background image
        let width:CGFloat = self.view.frame.width
        let height:CGFloat = self.view.frame.size.height-segmentedControl.frame.size.height-74
        let xAxis:CGFloat = 0
        let yAxis:CGFloat = segmentedControl.frame.origin.y+segmentedControl.frame.size.height+10
        
        tableViewMovies = UITableView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height), style: UITableViewStyle.Plain)
        tableViewMovies.tag = 1
        tableViewMovies.layoutSubviews()
        tableViewMovies.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableViewMovies.allowsMultipleSelectionDuringEditing = false
        tableViewMovies.delegate = self
        tableViewMovies.dataSource = self
        tableViewMovies.backgroundColor = UIColor.clearColor()//UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
        tableViewMovies.separatorStyle = UITableViewCellSeparatorStyle.None
        tableViewMovies.showsVerticalScrollIndicator = false
        tableViewMovies.showsHorizontalScrollIndicator = false
        tableViewMovies.rowHeight = 50
        self.view.addSubview(tableViewMovies)
    }
    
    //MARK: table view delegate/data source
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "MoviesTableViewCell"
        
        var cell: MoviesTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? MoviesTableViewCell
        if cell == nil{
            let rectFrame = tableView.rectForRowAtIndexPath(indexPath)
            
            cell = MoviesTableViewCell(style: .Default, reuseIdentifier: identifier, frameCell: rectFrame)
        }
        
        let dictItem = arrayMoviesList[(indexPath as NSIndexPath).row] as! NSDictionary
        
        print("Cell dictionary: \(dictItem)")
        
        //cell.setLblTitleName(dictItem.valueForKey("item") as! String)
        
        var strURLCode:String? = "\(dictItem.valueForKey( "Mov_Image"))"
//        if strURLCode!.containsString("http"){
//            strURLCode! = ""
//        }
        
//        var strURLtoAppend:String = String(format: "http://img.youtube.com/vi/rQUj5Mf6iiA/hqdefault.jpg", strURLCode!)
        if strURLCode!.containsString("Optional("){
            strURLCode = strURLCode!.stringByReplacingOccurrencesOfString("Optional(", withString: "")
        }
        if strURLCode!.containsString(")"){
            strURLCode = strURLCode!.stringByReplacingOccurrencesOfString(")", withString: "")
        }
        
        if (indexPath as NSIndexPath).row%2 == 0{
            cell.backgroundColor = UIColor.init(colorLiteralRed: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0)//UIColor.init(colorLiteralRed: 17/255.0, green: 18/255.0, blue: 21/255.0, alpha: 1.0)
        }
        else{
            cell.backgroundColor = UIColor.init(colorLiteralRed: 12/255.0, green: 13/255.0, blue: 15/255.0, alpha: 1.0)
        }
        
        
        
        let url = NSURL(string: strURLCode!)
        let imgPlaceholder = UIImage(named: "placeholder_movie")
        cell.imgViewMovies.image = imgPlaceholder
        
        //ImagedNeeded
        cell.imgViewMovies.kf_setImageWithURL(url!, placeholderImage: imgPlaceholder, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        
        //http://img.youtube.com/vi/<insert-youtube-image-id-here>/1.jpg
        
        cell.lblTitle.text = dictItem.valueForKey( "Mov_Name") as? String
//        cell.lblTitle.autoresize()
        
//        cell.lblPercent.text = "\(dictItem.valueForKey("rating")!)%"
        
        return cell
    }
    
    
    // number of rows in table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMoviesList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected item: \((indexPath as NSIndexPath).row)  withItem: \(arrayMoviesList[(indexPath as NSIndexPath).row])")
        
        //  let selectedMovie : NSDictionary = arrayMoviesList[indexPath.row] as! NSDictionary
        
        
        //  let movieDetailViewController = MovieDetailViewController(selectedMovie: selectedMovie)
        
        // Creating a navigation controller with viewController at the root of the navigation stack.
        //  let navController = UINavigationController(rootViewController: movieDetailViewController)
        //    self.presentViewController(navController, animated:true, completion: nil)
        //  self.navRef.pushViewController(movieDetailViewController, animated: true)
        
        
        
        //        movieDetailViewController.navigationController?.navigationBarHidden = false
        //        let navController = UINavigationController(rootViewController: movieDetailViewController)
        //        presentViewController(navController, animated: true, completion: nil)
        //        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
        //        presentViewController(movieDetailViewController, animated: true, completion: nil)
        
        //        let storyRef = UIStoryboard(name: "Main", bundle: nil)
        //        let newVC = storyRef.instantiateViewControllerWithIdentifier("newVC")
        //        presentViewController(newVC, animated: true, completion: nil)
        
        let selectedMovie : NSDictionary = arrayMoviesList[(indexPath as NSIndexPath).row] as! NSDictionary
        
        
        let movieDetailVC = MoviesDetailVC(selectedMovie: selectedMovie)
        movieDetailVC.navigCRef = navigRef
        movieDetailVC.controlRef = controlRef
        navigRef!.pushViewController(movieDetailVC, animated: true)
        
        
        
    }
    
    
    //MARK: - TableView scrollview delegates
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.isKindOfClass(  UITableView.self){
            
            let topYAxis:CGFloat = scrollView.contentOffset.y + scrollView.contentInset.top
            
            if previousScrollViewvalue > topYAxis+150{
                
                UIView.animateWithDuration( 0.3, animations: {
                    self.segmentedControl.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
                    
                    self.tableViewMovies.frame = CGRect(x: 0, y: self.segmentedControl.frame.size.height+self.segmentedControl.frame.origin.y+10, width: self.view.frame.width, height: self.view.frame.size.height-self.segmentedControl.frame.size.height-74)
                });
            }
            
            if topYAxis > 100 && previousScrollViewvalue < topYAxis-150{
                UIView.animateWithDuration( 0.3, animations: {
                    self.segmentedControl.frame = CGRect(x: 0, y: -44, width: self.view.frame.width, height: 44)
                    
                    self.tableViewMovies.frame = CGRect(x: 0, y: self.segmentedControl.frame.size.height+self.segmentedControl.frame.origin.y+10, width: self.view.frame.width, height: self.view.frame.size.height-self.segmentedControl.frame.size.height-74+44)
                });
            }
            
            if(topYAxis <= 20){
                UIView.animateWithDuration( 0.3, animations: {
                    self.segmentedControl.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
                    
                    self.tableViewMovies.frame = CGRect(x: 0, y: self.segmentedControl.frame.size.height+self.segmentedControl.frame.origin.y+10, width: self.view.frame.width, height: self.view.frame.size.height-self.segmentedControl.frame.size.height-74)
                });
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let topYAxis:CGFloat = scrollView.contentOffset.y + scrollView.contentInset.top
        previousScrollViewvalue = topYAxis
    }
    
    
//    //Location related
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        if !isLocationReceived{
//            isLocationReceived = true
//            
//            print("Didupdate to location: \(locations)")
//            
//            var currentLocation = CLLocation()
//            currentLocation = locations[0]
//            
//            locationDictionary["lat"] = currentLocation.coordinate.latitude
//            locationDictionary["lon"] = currentLocation.coordinate.longitude
//            
//            for (index , k) in self.arrayCacheMoviesList.enumerate() {
//                
//                let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double((k["Latitude"] as! NSString).doubleValue), longitude: Double((k["Longitude"] as! NSString).doubleValue))
//                
//                //let locationObj: CLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
//                //self.arrayLatAndLongs.addObject(locationObj)
//                //
//                //let location = CLLocation(latitude: (k["Latitude"] as? CLLocationDegrees)!, longitude: (k["Longitude"] as? CLLocationDegrees)!)
//                
//                let locationObj: CLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
//                
//                let distance = locationObj.distanceFromLocation(currentLocation)
//                (self.arrayCacheTheatreList[index] as! NSDictionary).setValue(distance, forKey: "distance")
//            }
//            
//            
//            let arySorted = self.arrayCacheTheatreList.sort{
//                (($0 as! Dictionary<String, AnyObject>)["distance"] as? CLLocationDistance) < (($1 as! Dictionary<String, AnyObject>)["distance"] as? CLLocationDistance)
//            }
//            self.arrayMoviesList.removeAllObjects()
//            self.arrayMoviesList.addObjectsFromArray(arySorted)
//            
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                print("Made a theater reload request: In side main thread")
//                print("sffgdgdhdfhdfhfh \(self.arrayTheatersList)")
//                self.tableViewMovies.reloadData()
//            }
//            
//        }
//    }
    
    
    //MARK: - ScrollNotification
    @objc func scrolledToPageZero(notification: NSNotification){
        //do stuff
        print("Scrolled to page zero")
        
        //        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        //        tableViewMovies.scrollToRowAtIndexPath(indexPath,
        //                                              atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
        
        //        var width:CGFloat = self.view.frame.width
        //        var height:CGFloat = 44
        //        var xAxis:CGFloat = 0
        //        var yAxis:CGFloat = 64
        //        segmentedControl.frame = CGRectMake(xAxis, yAxis, width, height)
        //
        //
        //        width = self.view.frame.width
        //        height = self.view.frame.size.height-segmentedControl.frame.size.height-64
        //        xAxis = 0
        //        yAxis = segmentedControl.frame.origin.y+segmentedControl.frame.size.height
        //
        //        tableViewMovies.frame = CGRectMake(xAxis, yAxis, width, height)
    }
    
    @objc func scrolledToPageMovies(notification: NSNotification){
        //do stuff
        print("Scrolled to page Movies")
        
        let userDefaults = UserDefaultsStore.userDefaults
        userDefaults.valueForKey("lid")
        
        let dictLocationDetails = userDefaults.valueForKey("lid")
        print("dictLocationDetails: \(dictLocationDetails)")
        
        
        
        
//        dictLocationDetails: Optional({
//        city = vijayawada;
//        latitude = "16.5062";
//        lid = 14;
//        longitude = "80.6480";
//        state = "Andhra Pradesh";
//        })

        
        
        //        var width:CGFloat = self.view.frame.width
        //        var height:CGFloat = 44
        //        var xAxis:CGFloat = 0
        //        var yAxis:CGFloat = 64
        //        segmentedControl.frame = CGRectMake(xAxis, yAxis, width, height)
        //
        //
        //        width = self.view.frame.width
        //        height = self.view.frame.size.height-segmentedControl.frame.size.height-64
        //        xAxis = 0
        //        yAxis = segmentedControl.frame.origin.y+segmentedControl.frame.size.height
        //
        //        tableViewMovies.frame = CGRectMake(xAxis, yAxis, width, height)
        
    }
    
    
    //MARK: - Services part
    func getMoviesList() {
        
        //Adding activity view to self.view
        if ARSLineProgress.shown { return }
        ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
            
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.userInteractionEnabled = false
//        self.view.userInteractionEnabled = false
        
        print("Getting movies list")
        
        let url_ = NSURL(string: "http://citymoviesapi.bananaapps.co.in/api/Movie/MovieDetails")
        let request = NSURLRequest(URL: url_!)
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
                            //                        print("\(json)")
                            
                            let arrayMovieDetails = json.valueForKey("MovieDetails") as! NSArray
                            
                            if let json = arrayMovieDetails as? NSArray {
                                
                                //                            print("\(json)")
                                
                                for item_ in json {
                                    //                                print("\(item_)")
                                    let dictMutable = NSMutableDictionary()
                                    
                                    let obj = item_ as! NSDictionary
                                    //                                print("\(obj)")
                                    for (key, value) in obj {
                                        dictMutable.setValue(value, forKey: key as! String)
                                    }
                                    //                                print("\(dictMutable)")
                                    self.arrayCacheMoviesList.addObject(dictMutable)
                                    //                                print("\(self.arrayCacheMoviesList)")
                                }
                            }
                            
                            print("Got all the movies array list")
                            
                            let arySorted = self.arrayCacheMoviesList.sort{
                                (($0 as! Dictionary<String, AnyObject>)["Release_Date"] as? String) > (($1 as! Dictionary<String, AnyObject>)["Release_Date"] as? String)
                            }
                            
                            self.arrayMoviesList.removeAllObjects()
                            self.arrayMoviesList.addObjectsFromArray(arySorted)
                            
                            print("Array sroted in date: \(arySorted)")
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                
                                //                            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                                //
                                //                            let moviesList = appDelegate.getValues("Movies")
                                //                            if moviesList.count > 0{
                                //                                appDelegate.deleteEntity("Movies")
                                //                            }
                                //
                                //                            for movie in self.arrayMoviesList{
                                //                                appDelegate.setValuesToEntity("Movies", withDictionary: movie as! NSDictionary)
                                //                            }
                                
                                self.tableViewMovies.reloadData()
                            }
                            
                        } else if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
                            // process "json" as an array
                            
                            
                        } else {
                            //                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                            //                        print("Error could not parse movies JSON string: \(jsonStr)")
                            print("Error could not parse movies JSON string:")
                        }
                        
                    } catch {
                        print("error serializing movies JSON: \(error)")
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
    
    //MARK: - Services part
    func refreshMoviesList() {
        
        
        print("Getting movies list")
        
        let url_ = NSURL(string: "http://citymoviesapi.bananaapps.co.in/api/Movie")
        let request = NSURLRequest(URL: url_!)
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
                            //                        print("\(json)")
                            
                            let arrayMovieDetails = json.valueForKey("MovieDetails") as! NSArray
                            
                            if let json = arrayMovieDetails as? NSArray {
                                
                                //                            print("\(json)")
                                
                                self.arrayCacheMoviesList.removeAllObjects()
                                
                                for item_ in json {
                                    //                                print("\(item_)")
                                    let dictMutable = NSMutableDictionary()
                                    
                                    let obj = item_ as! NSDictionary
                                    //                                print("\(obj)")
                                    for (key, value) in obj {
                                        dictMutable.setValue(value, forKey: key as! String)
                                    }
                                    //                                print("\(dictMutable)")
                                    self.arrayCacheMoviesList.addObject(dictMutable)
                                    print("\(self.arrayCacheMoviesList)")
                                }
                            }
                            
                            print("Got all the movies array list")
                            
                            let arySorted = self.arrayCacheMoviesList.sort{
                                (($0 as! Dictionary<String, AnyObject>)["Release_Date"] as? String) > (($1 as! Dictionary<String, AnyObject>)["Release_Date"] as? String)
                            }
                            
                            self.arrayMoviesList.removeAllObjects()
                            self.arrayMoviesList.addObjectsFromArray(arySorted)
                            
                            print("Array sroted in date: \(arySorted)")
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                
                                //                            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                                //
                                //                            let moviesList = appDelegate.getValues("Movies")
                                //                            if moviesList.count > 0{
                                //                                appDelegate.deleteEntity("Movies")
                                //                            }
                                //
                                //                            for movie in self.arrayMoviesList{
                                //                                appDelegate.setValuesToEntity("Movies", withDictionary: movie as! NSDictionary)
                                //                            }
                                
                                self.tableViewMovies.reloadData()
                            }
                            
                        } else if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
                            // process "json" as an array
                            
                            
                        } else {
                            //                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                            //                        print("Error could not parse movies JSON string: \(jsonStr)")
                            print("Error could not parse movies JSON string:")
                        }
                        
                    } catch {
                        print("error serializing movies JSON: \(error)")
                    }
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
//        let aryEntityValues:NSArray = appDelegate.getValues("Movies")
//        
//        if aryEntityValues.count > 0{
//            
//            for dicti in aryEntityValues{
//                
//                let movies_obj:Movies = dicti as! Movies
//                
//                let movies_DictObj = NSMutableDictionary()
//                movies_DictObj.setValue(movies_obj.actors, forKey: "Actors")
//                movies_DictObj.setValue(movies_obj.banner, forKey: "Banner")
//                movies_DictObj.setValue(movies_obj.censor, forKey: "Censor")
//                movies_DictObj.setValue(movies_obj.description_, forKey: "Description")
//                movies_DictObj.setValue(movies_obj.director, forKey: "director")
//                movies_DictObj.setValue(movies_obj.id, forKey: "Mov_ID")
//                movies_DictObj.setValue(movies_obj.iscommingsoon, forKey: "iscommingsoon")
//                movies_DictObj.setValue(movies_obj.language, forKey: "Language")
//                movies_DictObj.setValue(movies_obj.length, forKey: "Duration")
//                movies_DictObj.setValue(movies_obj.mainimage, forKey: "Mov_Image")
//                movies_DictObj.setValue(movies_obj.mdirector, forKey: "director")
//                movies_DictObj.setValue(movies_obj.mid, forKey: "Mov_ID")
//                movies_DictObj.setValue(movies_obj.mname, forKey: "Mov_Name")
//                movies_DictObj.setValue(movies_obj.movieType, forKey: "Movie_Type_Details")
//                movies_DictObj.setValue(movies_obj.producer, forKey: "producer")
//                movies_DictObj.setValue(movies_obj.rating, forKey: "AvgRating")
//                movies_DictObj.setValue(movies_obj.releasedate, forKey: "Release_Date")
//                movies_DictObj.setValue(movies_obj.storyLine, forKey: "Story_Line")
//                movies_DictObj.setValue(movies_obj.trailArUrl, forKey: "trailarurl")
//                movies_DictObj.setValue(movies_obj.voice, forKey: "voice")
//                movies_DictObj.setValue(movies_obj.writer, forKey: "writer")
//                
//                //NSDictionary *myDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:myData];
//                
//                let aryMovieImageList = NSKeyedUnarchiver.unarchiveObjectWithData(movies_obj.movieImagesList! as NSData) as! NSArray
//                if aryMovieImageList.count > 0 {
//                    movies_DictObj.setObject(aryMovieImageList, forKey: "MovieImages" as NSCopying)
//                }
//                else{
//                    movies_DictObj.setObject(NSArray(), forKey: "MovieImages" as NSCopying)
//                }
//                
////                let aryMovieInVenueList = NSKeyedUnarchiver.unarchiveObjectWithData(movies_obj.movieImagesList! as NSData) as! NSArray
////                if aryMovieInVenueList.count > 0 {
////                    movies_DictObj.setObject(aryMovieInVenueList, forKey: "movieBookingList" as NSCopying)
////                }
////                else{
////                    movies_DictObj.setObject(NSArray(), forKey: "movieBookingList" as NSCopying)
////                }
//                
//                let aryMovieVideosList = NSKeyedUnarchiver.unarchiveObjectWithData(movies_obj.movieImagesList! as NSData) as! NSArray
//                if aryMovieVideosList.count > 0 {
//                    movies_DictObj.setObject(aryMovieVideosList, forKey: "MovieVideos" as NSCopying)
//                }
//                else{
//                    movies_DictObj.setObject(NSArray(), forKey: "MovieVideos" as NSCopying)
//                }
//                
//                let aryMovieArtistList = NSKeyedUnarchiver.unarchiveObjectWithData(movies_obj.movieImagesList! as NSData) as! NSArray
//                if aryMovieArtistList.count > 0 {
//                    movies_DictObj.setObject(aryMovieArtistList, forKey: "MovieArtists" as NSCopying)
//                }
//                else{
//                    movies_DictObj.setObject(NSArray(), forKey: "MovieArtists" as NSCopying)
//                }
//                
//                let aryMovieRatings = NSKeyedUnarchiver.unarchiveObjectWithData(movies_obj.movierating! as NSData) as! NSArray
//                if aryMovieRatings.count > 0 {
//                    movies_DictObj.setObject(aryMovieRatings, forKey: "Movierating" as NSCopying)
//                }
//                else{
//                    movies_DictObj.setObject(NSArray(), forKey: "Movierating" as NSCopying)
//                }
//                
//                self.arrayCacheMoviesList.addObject(movies_DictObj)
//                self.arrayMoviesList.addObject(movies_DictObj)
//            }
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                print("Made a movies reload request: In side main thread. Fetching from coredata")
//                self.tableViewMovies.reloadData()
//                
//                self.refreshMoviesList()
//            }
//        }
//        else{
        
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                print("table reload called")
                self.getMoviesList()
            }
        
            
//            dispatch_async(dispatch_get_main_queue(),{
//                
//            })
//        }
    }
    
    
}
