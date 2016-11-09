//
//  UpComingViewController.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 07/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit
import Kingfisher

class UpComingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    //MARK: - Prorperties
    var segmentedControl = HMSegmentedControl()
    var tableViewUpcoming = UITableView()
    
    var arrayCacheUpcomingMoviesList = NSMutableArray()
    var arrayUpcomingMoviesList = NSMutableArray()
    
    var previousScrollViewvalue:CGFloat = 0.0
    
    //MARK: - Check and remove if necessary
    var navigRef : UINavigationController?
    var controlRef : SLPagingViewSwift?
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("navigation controller is \(self.navigationController)")
        
        //For scrollView logic
        previousScrollViewvalue = 20
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0)
        
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "loginBackground")?.drawInRect(self.view.bounds)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        self.view.backgroundColor = UIColor.init(patternImage: image)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(scrolledToPageUpcoming(_:)), name: "ScrolledToPageUpcoming", object: nil)
        
//        //Initialising diction
//        let dictTitles = NSMutableDictionary()
//        dictTitles.setValue("Star Wars", forKey: "title")
//        dictTitles.setValue("Moviestartwars", forKey: "image")
//        dictTitles.setValue("A", forKey: "rating")
//        dictTitles.setValue("82", forKey: "percent")
//        
//        let dictTitles1 = NSMutableDictionary()
//        dictTitles1.setValue("Star Wars", forKey: "title")
//        dictTitles1.setValue("Moviestartwars", forKey: "image")
//        dictTitles1.setValue("A", forKey: "rating")
//        dictTitles1.setValue("82", forKey: "percent")
//        
//        let dictTitles2 = NSMutableDictionary()
//        dictTitles2.setValue("Star Wars", forKey: "title")
//        dictTitles2.setValue("Moviestartwars", forKey: "image")
//        dictTitles2.setValue("A", forKey: "rating")
//        dictTitles2.setValue("82", forKey: "percent")
//        
//        let dictTitles3 = NSMutableDictionary()
//        dictTitles3.setValue("Star Wars", forKey: "title")
//        dictTitles3.setValue("Moviestartwars", forKey: "image")
//        dictTitles3.setValue("A", forKey: "rating")
//        dictTitles3.setValue("82", forKey: "percent")
//        
//        arrayUpcomingList.addObject(dictTitles1)
//        arrayUpcomingList.addObject(dictTitles2)
//        arrayUpcomingList.addObject(dictTitles3)
//        arrayUpcomingList.addObject(dictTitles)
        
        //        print("arryMoviesList: \(arrayUpcomingList)")
        
        designSegmentedControl()
        designTableView()
        
        getValuesFromCoreData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        getMoviesList()
//        tableViewUpcoming.reloadData()
        
    }
    
    //MARK: - Designing view
    func designSegmentedControl() {
        //Adding background image
        let width:CGFloat = self.view.frame.width
        let height:CGFloat = 44
        let xAxis:CGFloat = 0
        let yAxis:CGFloat = 0
        
        segmentedControl.sectionTitles = ["LATEST", "RATING"]
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
        
//        segmentedControl.indexChangeBlock = { (index) in
//            if index == 0{
//                print("Show LATEST")
//                
//            }
//            else if index == 1{
//                print("Show NEAR BY")
//                //Donot comment this line, else the table data will not be loaded
//                self.tableViewUpcoming.reloadData()
//                
//                
//            }
//            else{
//                print("Show UPCOMING")
//                
//            }
//        }
        
        
        
        segmentedControl.indexChangeBlock = { (index) in
            if index == 0{
                print("Show LATEST")
                
                let arySorted = self.arrayCacheUpcomingMoviesList.sort{
                    (($0 as! Dictionary<String, AnyObject>)["Release_Date"] as? String) > (($1 as! Dictionary<String, AnyObject>)["Release_Date"] as? String)
                }
                
                self.arrayUpcomingMoviesList.removeAllObjects()
                self.arrayUpcomingMoviesList.addObjectsFromArray(arySorted)
                
                print("Arry sorted: \(self.arrayUpcomingMoviesList)")
                
                self.tableViewUpcoming.reloadData()
            }
            else{
                print("Rating")
                //Donot comment this line, else the table data will not be loaded
                
                let arySorted = self.arrayCacheUpcomingMoviesList.sort{
                    (($0 as! Dictionary<String, AnyObject>)["AvgRating"] as? Int) > (($1 as! Dictionary<String, AnyObject>)["AvgRating"] as? Int)
                }
                
                self.arrayUpcomingMoviesList.removeAllObjects()
                self.arrayUpcomingMoviesList.addObjectsFromArray(arySorted)
                
                print("Arry sorted: \(self.arrayUpcomingMoviesList)")
                
                self.tableViewUpcoming.reloadData()
            }
        }
        
        
        
    }
    
    func designTableView() {
        
        //Adding background image
        let width:CGFloat = self.view.frame.width
        let height:CGFloat = self.view.frame.size.height-segmentedControl.frame.size.height-74
        let xAxis:CGFloat = 0
        let yAxis:CGFloat = segmentedControl.frame.origin.y+segmentedControl.frame.size.height+10
        
        tableViewUpcoming = UITableView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height), style: UITableViewStyle.Plain)
        tableViewUpcoming.tag = 1
        tableViewUpcoming.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableViewUpcoming.allowsMultipleSelectionDuringEditing = false
        tableViewUpcoming.delegate = self
        tableViewUpcoming.dataSource = self
        tableViewUpcoming.backgroundColor = UIColor.clearColor()//UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
        tableViewUpcoming.separatorStyle = UITableViewCellSeparatorStyle.None
        tableViewUpcoming.showsVerticalScrollIndicator = false
        tableViewUpcoming.showsHorizontalScrollIndicator = false
        tableViewUpcoming.rowHeight = 50;
        self.view.addSubview(tableViewUpcoming)
    }
    
    
    //MARK: - Table view delegate and datasource methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let identifier = "MoviesTableViewCellIdentifier"
//        
//        var cell: UpcomingTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? UpcomingTableViewCell
//        if cell == nil{
//            let rectFrame = tableView.rectForRowAtIndexPath(indexPath)
//            
//            cell = UpcomingTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier, frameCell: rectFrame)
//        }
        
        //        let dictItem = arrayUpcomingList[indexPath.row] as! NSDictionary
        
        //        cell.setLblTitleName(dictItem.valueForKey("item") as! String)
        
        let identifier = "UpcomingTableViewCellIdentifier"
        var cell: UpcomingTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? UpcomingTableViewCell
        if cell == nil{
            let rectFrame = tableView.rectForRowAtIndexPath(indexPath)
            
            cell = UpcomingTableViewCell(style: .Default, reuseIdentifier: identifier, frameCell: rectFrame)
        }
        
        
        let dictItem = arrayUpcomingMoviesList[(indexPath as NSIndexPath).row] as! NSDictionary
        
        //print("Cell dictionary: \(dictItem)")
        
        //cell.setLblTitleName(dictItem.valueForKey("item") as! String)
        
//        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: URL!) -> Void in
//            print(self)
//        }
        
        var strURLCode = "\(dictItem.valueForKey( "Mov_Image"))" as String
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
        
        
        
        let url = NSURL(string: strURLCode)
        //        cell.imgViewMovies.sd_setImageWithURL(url, completed: block)
        let imgPlaceholder = UIImage(named: "placeholder_movie")
        cell.imgViewMovies.image = imgPlaceholder
        
        //ImagedNeeded
        cell.imgViewMovies.kf_setImageWithURL(url!, placeholderImage: imgPlaceholder, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        
        //http://img.youtube.com/vi/<insert-youtube-image-id-here>/1.jpg
        
        cell.lblTitle.text = dictItem.valueForKey( "Mov_Name") as? String
        
        return cell
    }
    
    
    
    // number of rows in table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUpcomingMoviesList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected item: \((indexPath as NSIndexPath).row)  withItem: \(arrayUpcomingMoviesList[(indexPath as NSIndexPath).row])")
//        let movieDetailViewController = MovieDetailViewController(selectedMovie: [:])
//        navigationController?.pushViewController(movieDetailViewController, animated: true)
        
        let selectedMovie : NSDictionary = arrayUpcomingMoviesList[(indexPath as NSIndexPath).row] as! NSDictionary
        
        let movieDetailVC = MoviesDetailVC(selectedMovie: selectedMovie)
        movieDetailVC.navigCRef = navigRef
        movieDetailVC.controlRef = controlRef
        navigRef!.pushViewController(movieDetailVC, animated: true)
    }
    
    //MARK: - TableView scrollview delegates
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.isKindOfClass(UITableView.self){
            
            let topYAxis:CGFloat = scrollView.contentOffset.y + scrollView.contentInset.top
            
            if previousScrollViewvalue > topYAxis+150{
                
                UIView.animateWithDuration( 0.3, animations: {
                    self.segmentedControl.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
                    
                    self.tableViewUpcoming.frame = CGRect(x: 0, y: self.segmentedControl.frame.size.height+self.segmentedControl.frame.origin.y, width: self.view.frame.width, height: self.view.frame.size.height-self.segmentedControl.frame.size.height-74)
                });
            }
            
            if topYAxis > 100 && previousScrollViewvalue < topYAxis-150{
                UIView.animateWithDuration( 0.3, animations: {
                    self.segmentedControl.frame = CGRect(x: 0, y: -44, width: self.view.frame.width, height: 44)
                    
                    self.tableViewUpcoming.frame = CGRect(x: 0, y: self.segmentedControl.frame.size.height+self.segmentedControl.frame.origin.y+10, width: self.view.frame.width, height: self.view.frame.size.height-self.segmentedControl.frame.size.height-74+44)
                });
            }
            
            if(topYAxis <= 20){
                UIView.animateWithDuration( 0.3, animations: {
                    self.segmentedControl.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
                    
                    self.tableViewUpcoming.frame = CGRect(x: 0, y: self.segmentedControl.frame.size.height+self.segmentedControl.frame.origin.y+10, width: self.view.frame.width, height: self.view.frame.size.height-self.segmentedControl.frame.size.height-74)
                });
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let topYAxis:CGFloat = scrollView.contentOffset.y + scrollView.contentInset.top
        previousScrollViewvalue = topYAxis
    }
    
    //MARK: - ScrollNotification
    @objc func scrolledToPageUpcoming(notification: NSNotification){
        //do stuff
        print("Scrolled to page upcoming")
//        getValuesFromCoreData()
        
    }
    
    //MARK: - Services part
    func getUpcomingList() {
        
        let url_ = NSURL(string: "http://citymoviesapi.bananaapps.co.in/api/Movie/MovieDetails")
        let request = NSURLRequest(URL: url_!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            if response != nil {
                
                let httpResponse = response as! NSHTTPURLResponse
                let statusCode = httpResponse.statusCode
                print("upcoming -- Movies reponse with status code \(statusCode)")
                if (statusCode == 200) {
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                            // process "json" as a dictionary
                            //                        print("\(json)")
                            
                            let arrayMovieDetails = json.valueForKey("MovieDetails") as! NSArray
                            
                            
                            self.arrayCacheUpcomingMoviesList.removeAllObjects()
                            
                            if let json = arrayMovieDetails as? NSArray {
                                for item_ in json {
                                    let dictMutable = NSMutableDictionary()
                                    let obj = item_ as! NSDictionary
                                    for (key, value) in obj {
                                        dictMutable.setValue(value, forKey: key as! String)
                                    }
                                    self.arrayCacheUpcomingMoviesList.addObject(dictMutable)
                                }
                            }
                            
                            
                            
//                            print("just array: \(self.arrayCacheMoviesList)")
                            
                            let arySorted = self.arrayCacheUpcomingMoviesList.sort{
                                (($0 as! Dictionary<String, AnyObject>)["Release_Date"] as? String) > (($1 as! Dictionary<String, AnyObject>)["Release_Date"] as? String)
                            }
                            
                            
                            
                            self.arrayUpcomingMoviesList.removeAllObjects()
                            self.arrayCacheUpcomingMoviesList.removeAllObjects()
                            
                            for isComingItem in arySorted as! [NSDictionary]{
                                let dict : NSDictionary  = isComingItem as NSDictionary
                                
                                print("dictItem: \(dict)")
                                let iscommingsoon_value = dict.valueForKey("iscommingsoon") as! Bool
                                
                                if iscommingsoon_value {
                                    self.arrayUpcomingMoviesList.addObject(dict)
                                    self.arrayCacheUpcomingMoviesList.addObject(dict)
                                }
                            }
                            
                            
                            print("UpcomingMoviesList: \(self.arrayUpcomingMoviesList)")
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                //print("upcoming -- Made a movies reload request: In side main thread with array: \(self.arrayUpcomingMoviesList)")
                                
                                //                            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                                //
                                //                            let moviesList = appDelegate.getValues("Movies")
                                //                            if moviesList.count > 0{
                                //                                appDelegate.deleteEntity("Movies")
                                //                            }
                                //
                                //                            for movie in self.arrayUpcomingMoviesList{
                                //                                appDelegate.setValuesToEntity("Movies", withDictionary: movie as! NSDictionary)
                                //                            }
                                
                                self.tableViewUpcoming.reloadData()
                            }
                            
                            
                        } else if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
                            // process "json" as an array
                            
                            
                            
                        } else {
                            //                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                            //                        print("upcoming -- Error could not parse movies JSON string: \(jsonStr)")
                            print("Error could not parse movies JSON string:")
                        }
                        
                    } catch {
                        print("upcoming -- error serializing movies JSON: \(error)")
                    }
                }
            }
            else{
                print("Error in getting movies")
            }
        });
        
        // do whatever you need with the task e.g. run
        task.resume()
        
    }
    
    

//    func getValuesFromCoreData() {
//        
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
//                movies_DictObj.setValue(movies_obj.actors, forKey: "actors")
//                movies_DictObj.setValue(movies_obj.banner, forKey: "banner")
//                movies_DictObj.setValue(movies_obj.censor, forKey: "censor")
//                movies_DictObj.setValue(movies_obj.description_, forKey: "description")
//                movies_DictObj.setValue(movies_obj.director, forKey: "director")
//                movies_DictObj.setValue(movies_obj.id, forKey: "id")
//                movies_DictObj.setValue(movies_obj.iscommingsoon, forKey: "iscommingsoon")
//                movies_DictObj.setValue(movies_obj.language, forKey: "language")
//                movies_DictObj.setValue(movies_obj.length, forKey: "length")
//                movies_DictObj.setValue(movies_obj.mainimage, forKey: "mainimage")
//                movies_DictObj.setValue(movies_obj.mdirector, forKey: "mdirector")
//                movies_DictObj.setValue(movies_obj.mid, forKey: "mid")
//                movies_DictObj.setValue(movies_obj.mname, forKey: "mname")
//                movies_DictObj.setValue(movies_obj.movieType, forKey: "movietype")
//                movies_DictObj.setValue(movies_obj.producer, forKey: "producer")
//                movies_DictObj.setValue(movies_obj.rating, forKey: "rating")
//                movies_DictObj.setValue(movies_obj.releasedate, forKey: "releasedate")
//                movies_DictObj.setValue(movies_obj.storyLine, forKey: "storyline")
//                movies_DictObj.setValue(movies_obj.trailArUrl, forKey: "trailarurl")
//                movies_DictObj.setValue(movies_obj.voice, forKey: "voice")
//                movies_DictObj.setValue(movies_obj.writer, forKey: "writer")
//                
//                //NSDictionary *myDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:myData];
//                
//                let aryMovieImageList = NSKeyedUnarchiver.unarchiveObjectWithData(movies_obj.movieImagesList! as NSData) as! NSArray
//                if aryMovieImageList.count > 0 {
//                    movies_DictObj.setObject(aryMovieImageList, forKey: "movieImagesList" as NSCopying)
//                }
//                else{
//                    movies_DictObj.setObject(NSArray(), forKey: "movieImagesList" as NSCopying)
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
//                    movies_DictObj.setObject(aryMovieVideosList, forKey: "movieVideosList" as NSCopying)
//                }
//                else{
//                    movies_DictObj.setObject(NSArray(), forKey: "movieVideosList" as NSCopying)
//                }
//                
//                let aryMovieArtists = NSKeyedUnarchiver.unarchiveObjectWithData(movies_obj.movieImagesList! as NSData) as! NSArray
//                if aryMovieArtists.count > 0 {
//                    movies_DictObj.setObject(aryMovieArtists, forKey: "movieArtists" as NSCopying)
//                }
//                else{
//                    movies_DictObj.setObject(NSArray(), forKey: "movieArtists" as NSCopying)
//                }
//                
//                self.arrayCacheMoviesList.addObject(movies_DictObj)
//                self.arrayUpcomingMoviesList.addObject(movies_DictObj)
//            }
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                print("Made a movies reload request: In side main thread. Fetching from coredata")
//                self.tableViewUpcoming.reloadData()
//                
//                self.getUpcomingList()
//            }
//        }
//        else{
//            getUpcomingList()
//        }
//    }
    
    
    
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
//                //                let aryMovieInVenueList = NSKeyedUnarchiver.unarchiveObjectWithData(movies_obj.movieImagesList! as NSData) as! NSArray
//                //                if aryMovieInVenueList.count > 0 {
//                //                    movies_DictObj.setObject(aryMovieInVenueList, forKey: "movieBookingList" as NSCopying)
//                //                }
//                //                else{
//                //                    movies_DictObj.setObject(NSArray(), forKey: "movieBookingList" as NSCopying)
//                //                }
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
//                self.arrayUpcomingMoviesList.addObject(movies_DictObj)
//            }
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                print("Made a movies reload request: In side main thread. Fetching from coredata")
//                self.tableViewUpcoming.reloadData()
//                
//                self.getUpcomingList()
//            }
//        }
//        else{
//            
//            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
//            dispatch_after(delayTime, dispatch_get_main_queue()) {
//                print("table reload called")
                self.getUpcomingList()
//            }
//            
//            
//            //            dispatch_async(dispatch_get_main_queue(),{
//            //                
//            //            })
//        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
}
