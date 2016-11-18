//
//  MenuViewController.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 04/06/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit
import Kingfisher
import CoreLocation

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate {
    
    //MARK: - Check and remove if necessary
    
    var viewMain = UIView()
    
    var imgViewProfile : UIImageView?
    var lblUserFirstName : UILabel?
    var btnSelectedLocation : UIButton?
    var segmentedControl = HMSegmentedControl()
    var scrollViewForDesigns = UIScrollView()
    
    var arrayLocations = NSMutableArray()
    var arrayLocationsCache = NSMutableArray()
    
    //Locations releated
    var arrayLatAndLongs = NSMutableArray()
    var geoCoder = CLGeocoder()
    var locationManager = CLLocationManager()
    
    var viewActivity = UIView()
    var viewLocation = UIView()
    var viewContactUs = UIView()
    var viewAboutUs = UIView()
    
    var viewForSearch = UIView()
    var btnSearchCancel = UIButton()
    var imgSearchIcon = UIImageView()
    var textFieldSearch = UITextField()
    var viewLine = UIView()
    
    var searchString = String()
    
    
    var navigRefe : UINavigationController?
    var controlRefe : SLPagingViewSwift?
    
    var tableViewSettings = UITableView()
    var tableViewLocations = UITableView()
    var arrayMoviesList = NSMutableArray()
    var viewProfile = UIView()
    
    var isSearchNotTapped = Bool()
    var isLocationLoaded = Bool()
    
    //MARK: - ViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0)
        
        viewMain = UIView(frame: self.view.bounds)
        viewMain.backgroundColor = UIColor.clearColor()
        self.view.addSubview(viewMain)
        
        //Designing profile view
        var width:CGFloat = viewMain.frame.width
        var height:CGFloat = viewMain.frame.height/3
        var xAxis:CGFloat = 0
        var yAxis:CGFloat = 0
        
        let imgViewProfileBackGround = UIImageView(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        imgViewProfileBackGround.image = UIImage(named: "Placeholder_male")
        imgViewProfileBackGround.contentMode = .ScaleAspectFill
        imgViewProfileBackGround.clipsToBounds = true
        viewMain.addSubview(imgViewProfileBackGround)
        
        viewProfile = UIView(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        viewProfile.backgroundColor = UIColor.init(red: 159/255.0, green: 86/255.0, blue: 220/255.0, alpha: 0.7)
        viewMain.addSubview(viewProfile)
        
        width = 25
        height = 25
        xAxis = 10
        yAxis = 10
        
        let btnLogout = UIButton(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        btnLogout.setImage(UIImage(named: "logout_icon"), forState: .Normal)
        btnLogout.addTarget(self, action: #selector(MenuViewController.logoutEvent(_:)), forControlEvents: .TouchUpInside)
        btnLogout.backgroundColor = UIColor.clearColor()
        viewProfile.addSubview(btnLogout)
        
        
        width = viewProfile.frame.width/4
        height = width
        xAxis = viewProfile.frame.size.width/2-width/2
        yAxis = viewProfile.frame.size.height/2-height/2-40
        
        imgViewProfile = UIImageView(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        imgViewProfile!.image = UIImage(named: "Placeholder_male")
        imgViewProfile!.layer.cornerRadius = width/2
        imgViewProfile!.clipsToBounds = true
        viewProfile.addSubview(imgViewProfile!)
        
        width = viewProfile.frame.width-30
        height = 25
        xAxis = viewProfile.frame.size.width/2-width/2
        yAxis = imgViewProfile!.frame.size.height+imgViewProfile!.frame.origin.y+10
        
        lblUserFirstName = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblUserFirstName!.text = "Goutham"
        lblUserFirstName!.textColor = UIColor.whiteColor()
        lblUserFirstName!.font = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
        lblUserFirstName!.textAlignment = NSTextAlignment.Center
        lblUserFirstName!.backgroundColor = UIColor.clearColor()
        viewProfile.addSubview(lblUserFirstName!)
        
        
        width = viewProfile.frame.width-30
        height = 25
        xAxis = viewProfile.frame.size.width/2-width/2
        yAxis = lblUserFirstName!.frame.size.height+lblUserFirstName!.frame.origin.y+10
        
        btnSelectedLocation = UIButton(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        btnSelectedLocation?.setTitle("Select a location", forState: UIControlState())
        btnSelectedLocation?.setTitleColor(UIColor.whiteColor(), forState: UIControlState())
        btnSelectedLocation?.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16.0)
        btnSelectedLocation!.backgroundColor = UIColor.clearColor()
        viewProfile.addSubview(btnSelectedLocation!)
        
        //Updating to already selected location. Else nearest location must be selected.
        let userDefaults = UserDefaultsStore.userDefaults
        let dictLocation = userDefaults.valueForKey("lid") as? NSDictionary
        
        if let dictLocation_name = dictLocation?.valueForKey("city") {
            btnSelectedLocation?.setTitle(dictLocation_name as? String, forState: UIControlState())
        }
        
        
        //Chnaging menu profile values based on UserDefaults and FB details
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            
//            FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, email"]).startWithCompletionHandler(connection, result, error) -> Void in
            
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if ((error) != nil)
                {
                    // Process error
                    print("Error: \(error)")
                    
                    var strUserName:String! = UserDefaultsStore.userDefaults.objectForKey(UserDefaultsKeys.kUserNameKey) as! String
                    
                    strUserName = strUserName.stringByReplacingOccurrencesOfString("Optional(", withString: "")
                    strUserName = strUserName.stringByReplacingOccurrencesOfString(")", withString: "")
                    
                    self.lblUserFirstName?.text = strUserName
                    
                    let imgPlaceholder = UIImage(named: "Placeholder_male")
                    self.imgViewProfile?.image = imgPlaceholder
                    imgViewProfileBackGround.image = imgPlaceholder
                    
                }
                else
                {
                    if result.valueForKey("email") != nil
                    {
                        print("fetched user: \(result)")
                        let userName : NSString = result.valueForKey("name") as! NSString
                        print("User Name is: \(userName)")
                        let userEmail : NSString = result.valueForKey( "email") as! NSString
                        print("User Email is: \(userEmail)")
                        let userID : NSString = result.valueForKey( "id") as! NSString
                        print("User Email is: \(userID)")
                        
                        self.lblUserFirstName?.text = userName as String
                        
                        let facebookProfileUrl = "http://graph.facebook.com/\(userID)/picture?type=large"
                        print("profile pic URL: \(facebookProfileUrl)")
                        
                        let url = NSURL(string: facebookProfileUrl)
                        let imgPlaceholder = UIImage(named: "Placeholder_male")
                        self.imgViewProfile?.image = imgPlaceholder
                        
                        //ImagedNeeded
                        self.imgViewProfile?.kf_setImageWithURL(url!, placeholderImage: imgPlaceholder, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                        
                    }
                    else{
                        
                        //Get the values from UserDefaults 
                        
                        if let strUserName_s = UserDefaultsStore.userDefaults.objectForKey(UserDefaultsKeys.kUserNameKey) as? String{
                            
                            print("User name: \(strUserName_s)")
                            
                            var strUserName:String! = UserDefaultsStore.userDefaults.objectForKey(UserDefaultsKeys.kUserNameKey) as! String
                            
                            strUserName = strUserName.stringByReplacingOccurrencesOfString("Optional(", withString: "")
                            strUserName = strUserName.stringByReplacingOccurrencesOfString(")", withString: "")
                            
                            self.lblUserFirstName?.text = strUserName
                            
                            let imgPlaceholder = UIImage(named: "Placeholder_male")
                            self.imgViewProfile?.image = imgPlaceholder
                            
                        }
                        else{
                            self.lblUserFirstName?.text = "Guest"
                            
                            let imgPlaceholder = UIImage(named: "Placeholder_male")
                            self.imgViewProfile?.image = imgPlaceholder
                        }
                    }
                }
            })
        }
        else
        {
            //Get the values from UserDefaults
            
            if let strUserName_s = UserDefaultsStore.userDefaults.objectForKey(UserDefaultsKeys.kUserNameKey) as? String{
                
                print("User name: \(strUserName_s)")
                
                var strUserName:String! = UserDefaultsStore.userDefaults.objectForKey(UserDefaultsKeys.kUserNameKey) as! String
                
                strUserName = strUserName.stringByReplacingOccurrencesOfString("Optional(", withString: "")
                strUserName = strUserName.stringByReplacingOccurrencesOfString(")", withString: "")
                
                self.lblUserFirstName?.text = strUserName
                
                let imgPlaceholder = UIImage(named: "Placeholder_male")
                self.imgViewProfile?.image = imgPlaceholder
                
            }
            else{
                self.lblUserFirstName?.text = "Guest"
                
                let imgPlaceholder = UIImage(named: "Placeholder_male")
                self.imgViewProfile?.image = imgPlaceholder
            }
            
        }
        
//        designTableVeiw()
        designSegmentedControl()
        designScrollView()
        designContactUs()
        designAboutUs()
        designLocation()
        
        
        getValuesFromCoreData_Locations()
    }
    
    func designSegmentedControl() {
        //Adding background image
        let width:CGFloat = viewMain.frame.width
        let height:CGFloat = 44
        let xAxis:CGFloat = 0
        let yAxis:CGFloat = viewProfile.frame.size.height+viewProfile.frame.origin.y
        //UIColor(red: 27/255, green: 207/255, blue: 240/255, alpha: 1.0)
        segmentedControl.sectionTitles = ["ACITVITY","LOCATION","CONTACT US","ABOUT US"]
        segmentedControl.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        let attributes = [
            NSFontAttributeName : UIFont.boldSystemFontOfSize(10.0),
            NSForegroundColorAttributeName : UIColor.whiteColor(), NSBackgroundColorAttributeName : UIColor.clearColor()]
        segmentedControl.selectedTitleTextAttributes = attributes
        segmentedControl.titleTextAttributes = attributes
        segmentedControl.tintColor = UIColor.whiteColor()
        segmentedControl.backgroundColor = UIColor.init(colorLiteralRed: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0)
        segmentedControl.selectionIndicatorColor = UIColor.init(red: 159/255.0, green: 86/255.0, blue: 220/255.0, alpha: 1.0)
        segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        segmentedControl.selectionIndicatorHeight = 2;
        viewMain.addSubview(segmentedControl)
        
        segmentedControl.indexChangeBlock = { (index) in
            if index == 0{
                print("ACTIVITY")
                
                self.scrollViewForDesigns.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
            else if index == 1{
                print("LOCATION")
                //Donot comment this line, else the table data will not be loaded

                self.scrollViewForDesigns.setContentOffset(CGPoint(x: self.viewMain.frame.width, y: 0), animated: true)
            }
            else if index == 2{
                print("CONTACT US")
                //Donot comment this line, else the table data will not be loaded
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.scrollViewForDesigns.setContentOffset(CGPoint(x: self.viewMain.frame.width*2, y: 0), animated: true)
                }
            }
            else{
                print("ABOUT US")
                dispatch_async(dispatch_get_main_queue()) {
                    self.scrollViewForDesigns.setContentOffset(CGPoint(x: self.viewMain.frame.width*3, y: 0), animated: true)
                }
            }
        }
    }
    
    func designScrollView() {
        
        //Designing table view
        let width:CGFloat = viewMain.frame.width
        let height:CGFloat = viewMain.frame.size.height-(64+viewProfile.frame.origin.y+viewProfile.frame.size.height+segmentedControl.frame.size.height)
        let xAxis:CGFloat = 0
        let yAxis:CGFloat = segmentedControl.frame.size.height+segmentedControl.frame.origin.y
        
        scrollViewForDesigns = UIScrollView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        scrollViewForDesigns.contentSize = CGSize(width: width*4, height: height)
        scrollViewForDesigns.backgroundColor = UIColor.clearColor()
        scrollViewForDesigns.pagingEnabled = true
        scrollViewForDesigns.scrollEnabled = false
        scrollViewForDesigns.showsVerticalScrollIndicator = false
        scrollViewForDesigns.showsHorizontalScrollIndicator = false
        viewMain.addSubview(scrollViewForDesigns)
        
        viewActivity = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        viewActivity.backgroundColor = UIColor.clearColor()
        scrollViewForDesigns.addSubview(viewActivity)
        
        viewLocation = UIView(frame: CGRect(x: viewActivity.frame.width, y: 0, width: width, height: height))
        viewLocation.backgroundColor = UIColor.clearColor()
        scrollViewForDesigns.addSubview(viewLocation)

        viewContactUs = UIView(frame: CGRect(x: viewLocation.frame.origin.x+viewLocation.frame.width, y: 0, width: width, height: height))
        viewContactUs.backgroundColor = UIColor.clearColor()
        scrollViewForDesigns.addSubview(viewContactUs)
        
        viewAboutUs = UIView(frame: CGRect(x: viewContactUs.frame.origin.x+viewContactUs.frame.width, y: 0, width: width, height: height))
        viewAboutUs.backgroundColor = UIColor.clearColor()
        scrollViewForDesigns.addSubview(viewAboutUs)
        
        
        designActivityView()
    }
    
    func designActivityView() {
        
        var width:CGFloat = scrollViewForDesigns.frame.width
        var height:CGFloat = scrollViewForDesigns.frame.height/3
        var xAxis:CGFloat = 0
        var yAxis:CGFloat = 0
        
        let viewShareApp  = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        viewShareApp.backgroundColor = UIColor.init(red: 17/255.0, green: 18/255.0, blue: 21/255.0, alpha: 1.0)
        viewActivity.addSubview(viewShareApp)
        
        let imgViewIcon = UIImageView(frame: CGRect(x: 20, y: height/2-(height/3.2)/2, width: height/3.2, height: height/3.2))
        imgViewIcon.image = UIImage(named: "share_icon")
        viewShareApp.addSubview(imgViewIcon)
        
        let lblShareApp = UILabel(frame: CGRect(x: imgViewIcon.frame.origin.x+imgViewIcon.frame.size.width+15, y: 0, width: width, height: viewShareApp.frame.size.height))
        lblShareApp.text = "SHARE APP"
        lblShareApp.textColor = UIColor.init(red: 159/255.0, green: 86/255.0, blue: 220/255.0, alpha: 1.0)
        lblShareApp.font = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
        viewShareApp.addSubview(lblShareApp)
        
        let btnShareApp = UIButton(type: .Custom)
        btnShareApp.frame = viewShareApp.frame
        btnShareApp.backgroundColor = UIColor.clearColor()
        btnShareApp.addTarget(self, action: #selector(shareEvent(_:)), forControlEvents: .TouchUpInside)
        viewShareApp.addSubview(btnShareApp)
        
        
        
        width = scrollViewForDesigns.frame.width
        height = scrollViewForDesigns.frame.height/3
        xAxis = 0
        yAxis = viewShareApp.frame.size.height
        
        let viewRateThisApp  = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        viewRateThisApp.backgroundColor = UIColor.init(colorLiteralRed: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0)//UIColor.clearColor()
        viewActivity.addSubview(viewRateThisApp)
        
        let imgViewIcon_rate = UIImageView(frame: CGRect(x: 20, y: height/2-(height/3)/2, width: height/3, height: height/3))
        imgViewIcon_rate.image = UIImage(named: "rate_icon")
        viewRateThisApp.addSubview(imgViewIcon_rate)
        
        let lblRateThisApp = UILabel(frame: CGRect(x: imgViewIcon.frame.origin.x+imgViewIcon.frame.size.width+15, y: 0, width: width, height: viewShareApp.frame.size.height))
        lblRateThisApp.text = "RATE THIS APP"
        lblRateThisApp.textColor = UIColor.init(red: 159/255.0, green: 86/255.0, blue: 220/255.0, alpha: 1.0)
        lblRateThisApp.font = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
        viewRateThisApp.addSubview(lblRateThisApp)
        
        let btnRateThisApp = UIButton(type: .Custom)
        btnRateThisApp.frame = viewRateThisApp.bounds
        btnRateThisApp.backgroundColor = UIColor.clearColor()
        btnRateThisApp.addTarget(self, action: #selector(rateThisAppEvent(_:)), forControlEvents: .TouchUpInside)
        viewRateThisApp.addSubview(btnRateThisApp)
        
        
        
        
        width = scrollViewForDesigns.frame.width
        height = scrollViewForDesigns.frame.height/3
        xAxis = 0
        yAxis = viewRateThisApp.frame.size.height+viewRateThisApp.frame.size.height
        
        let viewFeedBack  = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        viewFeedBack.backgroundColor = UIColor.init(red: 17/255.0, green: 18/255.0, blue: 21/255.0, alpha: 1.0)
        viewActivity.addSubview(viewFeedBack)
        
        let imgViewIcon_feedBack = UIImageView(frame: CGRect(x: 20, y: height/2-(height/3)/2, width: height/3, height: height/3))
        imgViewIcon_feedBack.image = UIImage(named: "feedback_icon")
        viewFeedBack.addSubview(imgViewIcon_feedBack)
        
        width = scrollViewForDesigns.frame.width
        height = scrollViewForDesigns.frame.height/3
        xAxis = 0
        yAxis = viewRateThisApp.frame.size.height+viewRateThisApp.frame.size.height
        
        let lblFeedBack = UILabel(frame: CGRect(x: imgViewIcon.frame.origin.x+imgViewIcon.frame.size.width+15, y: (viewFeedBack.frame.size.height/2-10)-8, width: width, height: 20))
        lblFeedBack.text = "FEED BACK"
        lblFeedBack.textColor = UIColor.init(red: 159/255.0, green: 86/255.0, blue: 220/255.0, alpha: 1.0)
        lblFeedBack.font = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
        viewFeedBack.addSubview(lblFeedBack)
        
        let lblFeedBack_subTitle = UILabel(frame: CGRect(x: imgViewIcon.frame.origin.x+imgViewIcon.frame.size.width+15, y: (viewFeedBack.frame.size.height/2-10)+8, width: width, height: 20))
        lblFeedBack_subTitle.text = "App an apt For online Movie Booking"
        lblFeedBack_subTitle.textColor = UIColor.init(red: 100/255.0, green: 102/255.0, blue: 109/255.0, alpha: 1.0)
        lblFeedBack_subTitle.font = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
        viewFeedBack.addSubview(lblFeedBack_subTitle)
        
        let btnFeedBack = UIButton(type: .Custom)
        btnFeedBack.frame = viewFeedBack.bounds
        btnFeedBack.backgroundColor = UIColor.clearColor()
        btnFeedBack.addTarget(self, action: #selector(feedBackEvent(_:)), forControlEvents: .TouchUpInside)
        viewFeedBack.addSubview(btnFeedBack)
        
        
        
    }
    
    
    func designLocation() {
        
        var width:CGFloat = scrollViewForDesigns.frame.width
        var height:CGFloat = 45
        var xAxis:CGFloat = (scrollViewForDesigns.frame.width/3-13)-30
        var yAxis:CGFloat = 0
        
        viewForSearch = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        viewForSearch.backgroundColor = UIColor.clearColor()
        viewLocation.addSubview(viewForSearch)
        
        
        width = scrollViewForDesigns.frame.width/2
        height = 1.5
        xAxis = 30
        yAxis = 40
        
        viewLine = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        viewLine.backgroundColor = UIColor.init(red: 159/255.0, green: 86/255.0, blue: 220/255.0, alpha: 1.0)
        viewForSearch.addSubview(viewLine)
        
        width = scrollViewForDesigns.frame.width/2-30
        height = 30
        xAxis = 32
        yAxis = viewLine.frame.origin.y-(3+height)
        
        textFieldSearch.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        textFieldSearch.backgroundColor = UIColor.clearColor()
        textFieldSearch.textColor = UIColor.whiteColor()
        textFieldSearch.tag = 1
        textFieldSearch.delegate = self
        textFieldSearch.borderStyle = UITextBorderStyle.None
        textFieldSearch.placeholder = "SEARCH CITY"
        textFieldSearch.setValue(UIColor.init(colorLiteralRed: 142/255.0, green: 142/255.0, blue: 142/255.0, alpha: 0.8), forKeyPath: "_placeholderLabel.textColor")
        textFieldSearch.autocorrectionType = UITextAutocorrectionType.No
        textFieldSearch.keyboardType = UIKeyboardType.Default
        textFieldSearch.keyboardAppearance = UIKeyboardAppearance.Dark
        textFieldSearch.autocapitalizationType = UITextAutocapitalizationType.None
        textFieldSearch.returnKeyType = UIReturnKeyType.Search
        textFieldSearch.clearButtonMode = UITextFieldViewMode.WhileEditing
        textFieldSearch.font = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        textFieldSearch.tintColor = UIColor.whiteColor()
        viewForSearch.addSubview(textFieldSearch)
        
        width = 20
        height = 20
        xAxis = textFieldSearch.frame.origin.x+textFieldSearch.frame.width+5
        yAxis = textFieldSearch.frame.origin.y+textFieldSearch.frame.height/2-height/2
        
        imgSearchIcon = UIImageView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        imgSearchIcon.image = UIImage(named: "search_icon")
        imgSearchIcon.backgroundColor = UIColor.clearColor()
        viewForSearch.addSubview(imgSearchIcon)
        
        
        width = 50
        height = viewForSearch.frame.height
        xAxis = viewForSearch.frame.size.width-55
        yAxis = 0
        
        btnSearchCancel = UIButton(type: .Custom)
        btnSearchCancel.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        btnSearchCancel.backgroundColor = UIColor.clearColor()
        btnSearchCancel.setTitle("Cancel", forState: UIControlState())
        btnSearchCancel.addTarget(self, action: #selector(searchCancelTapped(_:)), forControlEvents: .TouchUpInside)
        btnSearchCancel.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        viewForSearch.addSubview(btnSearchCancel)
        
        
        //Designing table view
        xAxis = (scrollViewForDesigns.frame.width/3-13)-12
        yAxis = viewLine.frame.origin.y+viewLine.frame.size.height+10
        width = viewLocation.frame.width-(xAxis+10)
        height = viewLocation.frame.height-(yAxis+5)
        
        tableViewLocations = UITableView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height), style: UITableViewStyle.Plain)
        tableViewLocations.tag = 2
        tableViewLocations.layoutSubviews()
        tableViewLocations.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableViewLocations.allowsMultipleSelectionDuringEditing = false
        tableViewLocations.delegate = self
        tableViewLocations.dataSource = self
        tableViewLocations.backgroundColor = UIColor.clearColor()//UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
        tableViewLocations.separatorStyle = UITableViewCellSeparatorStyle.None
        tableViewLocations.showsVerticalScrollIndicator = false
        tableViewLocations.showsHorizontalScrollIndicator = false
        tableViewLocations.rowHeight = 50;
        tableViewLocations.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        viewLocation.addSubview(tableViewLocations)
        
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(100000000 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            print("table reload called")
            self.tableViewLocations.reloadData()
        }
        
    }
    
    
    func designContactUs() {
        
        var width:CGFloat = scrollViewForDesigns.frame.width
        var height:CGFloat = scrollViewForDesigns.frame.height
        var xAxis:CGFloat = 0
        var yAxis:CGFloat = 0
        
        let viewOverLay = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        viewContactUs.addSubview(viewOverLay)
        
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0).CGColor, UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 0.1).CGColor]
        gradient.locations = [0.0 , 1.0]
//        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
//        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: viewOverLay.frame.size.width, height: viewOverLay.frame.size.height)
        viewOverLay.layer.insertSublayer(gradient, atIndex: 0)
        
        //Adding background image
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "loginBackground")?.drawInRect(viewContactUs.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        viewContactUs.backgroundColor = UIColor.init(patternImage: image!)
        
        
        let widthOfBananaLogo = 2.84*scrollViewForDesigns.frame.height/17
        
        width = scrollViewForDesigns.frame.width/1.9
        height = scrollViewForDesigns.frame.height/6
        xAxis = (viewContactUs.frame.width/2-width/2)-widthOfBananaLogo
        yAxis = 10
        
        
        let myAttribute = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 13.0)! ]
        let myString = NSMutableAttributedString(string: "CITY MOVIES", attributes: myAttribute )
        
        let fontAttribute_power = [NSFontAttributeName : UIFont(name: "HelveticaNeue-Medium", size: 14.0)!]
        let attrString = NSMutableAttributedString(string: " powerd by ", attributes: fontAttribute_power)
        myString.appendAttributedString(attrString)
        
        let myRange = NSRange(location: 12, length: 9) // range starting at location 17 with a lenth of 7: "Strings"
        myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 159/255.0, green: 86/255.0, blue: 220/255.0, alpha: 1.0), range: myRange)
        
        let myRange_powerColor = NSRange(location: 0, length: 11) // range starting at location 17 with a lenth of 7: "Strings"
        myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: myRange_powerColor)
        
        
        let lblTitle = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle.attributedText = myString
        lblTitle.textAlignment = .Center
        lblTitle.backgroundColor = UIColor.clearColor()
        lblTitle.autoresize()
        viewContactUs.addSubview(lblTitle)
        
        //Banana icon view
        let imageViewBanana = UIImageView(frame: CGRectMake(lblTitle.frame.width+lblTitle.frame.origin.x+2, (yAxis-((2.84*scrollViewForDesigns.frame.height/8)/2.84)/4)+2, 2.84*scrollViewForDesigns.frame.height/8, (2.84*scrollViewForDesigns.frame.height/8)/2.84))
        imageViewBanana.image = UIImage(named: "bananalogo_icon")
        viewContactUs.addSubview(imageViewBanana)
        
        
        //Designing view left and right based on line boarder
        
        width = viewContactUs.frame.width/4
        height = 1.5
        xAxis = 20
        yAxis = lblTitle.frame.height+lblTitle.frame.origin.y+12
        
        let viewBoarder = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        viewBoarder.backgroundColor = UIColor.init(red: 159/255.0, green: 86/255.0, blue: 220/255.0, alpha: 1.0)
        viewContactUs.addSubview(viewBoarder)
        
        
        width = viewContactUs.frame.width/2
        height = viewContactUs.frame.height-viewBoarder.frame.origin.y+viewBoarder.frame.size.height
        xAxis = 0
        yAxis = viewBoarder.frame.origin.y+5
        
        let viewLeft = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        viewLeft.backgroundColor = UIColor.clearColor()
        viewContactUs.addSubview(viewLeft)
        
        
        width = viewLeft.frame.width-30
        height = viewLeft.frame.size.height/6-3
        xAxis = 20
        yAxis = 0
        
        let lblTitle_Need = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_Need.text = "NEED"
        lblTitle_Need.textColor = UIColor.whiteColor()
        lblTitle_Need.textAlignment = .Left
        lblTitle_Need.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        viewLeft.addSubview(lblTitle_Need)
        
        width = viewLeft.frame.width-30
        height = viewLeft.frame.size.height/6-3
        xAxis = 20
        yAxis = lblTitle_Need.frame.size.height+lblTitle_Need.frame.origin.y
        
        let lblTitle_App = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_App.text = "APP"
        lblTitle_App.textColor = UIColor.whiteColor()
        lblTitle_App.textAlignment = .Left
        lblTitle_App.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        viewLeft.addSubview(lblTitle_App)
        
        width = viewLeft.frame.width-30
        height = viewLeft.frame.size.height/6-3
        xAxis = 20
        yAxis = lblTitle_App.frame.size.height+lblTitle_App.frame.origin.y
        
        let lblTitle_For = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_For.text = "FOR"
        lblTitle_For.textColor = UIColor.whiteColor()
        lblTitle_For.textAlignment = .Left
        lblTitle_For.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        viewLeft.addSubview(lblTitle_For)
        
        width = viewLeft.frame.width-30
        height = viewLeft.frame.size.height/6-3
        xAxis = 20
        yAxis = lblTitle_For.frame.size.height+lblTitle_For.frame.origin.y
        
        let lblTitle_Your = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_Your.text = "YOUR"
        lblTitle_Your.textColor = UIColor.whiteColor()
        lblTitle_Your.textAlignment = .Left
        lblTitle_Your.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        viewLeft.addSubview(lblTitle_Your)
        
        width = viewLeft.frame.width-30
        height = viewLeft.frame.size.height/6-3
        xAxis = 20
        yAxis = lblTitle_Your.frame.size.height+lblTitle_Your.frame.origin.y
        
        let lblTitle_Business = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_Business.text = "BUSINESS"
        lblTitle_Business.textColor = UIColor.whiteColor()
        lblTitle_Business.textAlignment = .Left
        lblTitle_Business.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        viewLeft.addSubview(lblTitle_Business)
        
        width = viewLeft.frame.width-30
        height = viewLeft.frame.size.height/6-3
        xAxis = 20
        yAxis = lblTitle_Business.frame.size.height+lblTitle_Business.frame.origin.y
        
        let lblTitle_Que = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_Que.text = "?"
        lblTitle_Que.textColor = UIColor.whiteColor()
        lblTitle_Que.textAlignment = .Left
        lblTitle_Que.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        viewLeft.addSubview(lblTitle_Que)
        
        
        
        //Designing on view right
        width = viewContactUs.frame.width/2
        height = viewContactUs.frame.height
        xAxis = viewContactUs.frame.width/2
        yAxis = viewBoarder.frame.origin.y+5
        
        let viewRight = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        viewRight.backgroundColor = UIColor.clearColor()
        viewContactUs.addSubview(viewRight)
        
        
        width = viewRight.frame.width
        height = viewRight.frame.size.height/10
        xAxis = 10
        yAxis = 0
        
        let lblTitle_ContactUs = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_ContactUs.text = "CONTACT US"
        lblTitle_ContactUs.textColor = UIColor.whiteColor()
        lblTitle_ContactUs.textAlignment = .Left
        lblTitle_ContactUs.font = UIFont(name: "HelveticaNeue", size: 15.0)
        viewRight.addSubview(lblTitle_ContactUs)
        

        width = viewRight.frame.width
        height = viewRight.frame.size.height/10
        xAxis = 10
        yAxis = lblTitle_ContactUs.frame.size.height+lblTitle_ContactUs.frame.origin.y+8
        
        let btnTitle_Number = UIButton(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        btnTitle_Number.setTitle("+44-191 273 169", forState: UIControlState())
        btnTitle_Number.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        btnTitle_Number.titleLabel?.textAlignment = NSTextAlignment.Left
        btnTitle_Number.setTitleColor(UIColor.whiteColor(), forState: UIControlState())
        btnTitle_Number.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 13.0)
        btnTitle_Number.addTarget(self, action: #selector(callEvent(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        viewRight.addSubview(btnTitle_Number)
        
    
        width = viewRight.frame.width
        height = viewRight.frame.size.height/10
        xAxis = 10
        yAxis = btnTitle_Number.frame.size.height+btnTitle_Number.frame.origin.y+8
        
        let btnTitle_Email = UIButton(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        btnTitle_Email.setTitle("info@banana-apps.com", forState: UIControlState())
        btnTitle_Email.titleLabel?.textAlignment = NSTextAlignment.Left
        btnTitle_Email.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        btnTitle_Email.setTitleColor(UIColor.whiteColor(), forState: UIControlState())
        btnTitle_Email.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 13.0)
        btnTitle_Email.addTarget(self, action: #selector(emailEvent(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        viewRight.addSubview(btnTitle_Email)
        
        
        width = viewRight.frame.width
        height = viewRight.frame.size.height/10
        xAxis = 10
        yAxis = btnTitle_Email.frame.size.height+btnTitle_Email.frame.origin.y+8
        
        let btnTitle_Web = UIButton(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        btnTitle_Web.setTitle("www.bananaapps.co.uk", forState: UIControlState())
        btnTitle_Web.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        btnTitle_Web.titleLabel?.textAlignment = NSTextAlignment.Left
        btnTitle_Web.setTitleColor(UIColor.whiteColor(), forState: UIControlState())
        btnTitle_Web.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 13.0)
        btnTitle_Web.addTarget(self, action: #selector(webEvent(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        viewRight.addSubview(btnTitle_Web)
        
        
        width = viewRight.frame.width
        height = viewRight.frame.size.height/10
        xAxis = 10
        yAxis = btnTitle_Web.frame.size.height+btnTitle_Web.frame.origin.y+8
        
        let btnTitle_MoreApp = UIButton(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        btnTitle_MoreApp.setTitle("MORE APPS", forState: UIControlState())
        btnTitle_MoreApp.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        btnTitle_MoreApp.titleLabel?.textAlignment = NSTextAlignment.Left
        btnTitle_MoreApp.setTitleColor(UIColor.whiteColor(), forState: UIControlState())
        btnTitle_MoreApp.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 13.0)
        btnTitle_MoreApp.addTarget(self, action: #selector(moreAppEvent(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        viewRight.addSubview(btnTitle_MoreApp)
        
        
        
    }
    
    func designAboutUs() {
        
        var width:CGFloat = scrollViewForDesigns.frame.width
        var height:CGFloat = scrollViewForDesigns.frame.height
        var xAxis:CGFloat = 0
        var yAxis:CGFloat = 0
        
        let viewOverLay = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        viewAboutUs.addSubview(viewOverLay)
        
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0).CGColor, UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 0.1).CGColor]
        gradient.locations = [0.0 , 1.0]
        //        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        //        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: viewOverLay.frame.size.width, height: viewOverLay.frame.size.height)
        viewOverLay.layer.insertSublayer(gradient, atIndex: 0)
        
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "loginBackground")?.drawInRect( viewAboutUs.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        viewAboutUs.backgroundColor = UIColor.init(patternImage: image!)
        
        
        width = scrollViewForDesigns.frame.width
        height = scrollViewForDesigns.frame.height/6
        xAxis = 0
        yAxis = 10
        
        
        let myAttribute = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 15.0)! ]
        let myString = NSMutableAttributedString(string: "CITY MOVIES", attributes: myAttribute )
        let myRange_powerColor = NSRange(location: 0, length: 11) // range starting at location 17 with a lenth of 7: "Strings"
        myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: myRange_powerColor)
        
        
        let lblTitle = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle.attributedText = myString
        lblTitle.textAlignment = .Center
        lblTitle.backgroundColor = UIColor.clearColor()
        viewAboutUs.addSubview(lblTitle)
        
        
        
        //Designing view left and right based on line boarder
        
        width = viewAboutUs.frame.width/4
        height = 1.5
        xAxis = 20
        yAxis = lblTitle.frame.height+lblTitle.frame.origin.y+6
        
        let viewBoarder = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        viewBoarder.backgroundColor = UIColor.init(red: 159/255.0, green: 86/255.0, blue: 220/255.0, alpha: 1.0)
        viewAboutUs.addSubview(viewBoarder)
        
        
        width = viewAboutUs.frame.width/2
        height = viewAboutUs.frame.height-viewBoarder.frame.origin.y+viewBoarder.frame.size.height
        xAxis = 0
        yAxis = viewBoarder.frame.origin.y+5
        
        let viewLeft = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        viewLeft.backgroundColor = UIColor.clearColor()
        viewAboutUs.addSubview(viewLeft)
        
        
        width = viewLeft.frame.width-30
        height = viewLeft.frame.size.height/6-3
        xAxis = 20
        yAxis = 0
        
        let lblTitle_Need = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_Need.text = "WHAT"
        lblTitle_Need.textColor = UIColor.whiteColor()
        lblTitle_Need.textAlignment = .Left
        lblTitle_Need.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        viewLeft.addSubview(lblTitle_Need)
        
        width = viewLeft.frame.width-30
        height = viewLeft.frame.size.height/6-3
        xAxis = 20
        yAxis = lblTitle_Need.frame.size.height+lblTitle_Need.frame.origin.y
        
        let lblTitle_App = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_App.text = "IS"
        lblTitle_App.textColor = UIColor.whiteColor()
        lblTitle_App.textAlignment = .Left
        lblTitle_App.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        viewLeft.addSubview(lblTitle_App)
        
        width = viewLeft.frame.width-30
        height = viewLeft.frame.size.height/6-3
        xAxis = 20
        yAxis = lblTitle_App.frame.size.height+lblTitle_App.frame.origin.y
        
        let lblTitle_For = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_For.text = "THIS"
        lblTitle_For.textColor = UIColor.whiteColor()
        lblTitle_For.textAlignment = .Left
        lblTitle_For.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        viewLeft.addSubview(lblTitle_For)
        
        width = viewLeft.frame.width-30
        height = viewLeft.frame.size.height/6-3
        xAxis = 20
        yAxis = lblTitle_For.frame.size.height+lblTitle_For.frame.origin.y
        
        let lblTitle_Your = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_Your.text = "APP"
        lblTitle_Your.textColor = UIColor.whiteColor()
        lblTitle_Your.textAlignment = .Left
        lblTitle_Your.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        viewLeft.addSubview(lblTitle_Your)
        
        width = viewLeft.frame.width-30
        height = viewLeft.frame.size.height/6-3
        xAxis = 20
        yAxis = lblTitle_Your.frame.size.height+lblTitle_Your.frame.origin.y
        
        let lblTitle_Business = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_Business.text = "ABOUT"
        lblTitle_Business.textColor = UIColor.whiteColor()
        lblTitle_Business.textAlignment = .Left
        lblTitle_Business.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        viewLeft.addSubview(lblTitle_Business)
        
        width = viewLeft.frame.width-30
        height = viewLeft.frame.size.height/6-3
        xAxis = 20
        yAxis = lblTitle_Business.frame.size.height+lblTitle_Business.frame.origin.y
        
        let lblTitle_Que = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_Que.text = "?"
        lblTitle_Que.textColor = UIColor.whiteColor()
        lblTitle_Que.textAlignment = .Left
        lblTitle_Que.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        viewLeft.addSubview(lblTitle_Que)
        
        
        
        //Designing on view right
        width = viewAboutUs.frame.width/2
        height = viewAboutUs.frame.height
        xAxis = viewAboutUs.frame.width/2
        yAxis = viewBoarder.frame.origin.y-2
        
        let viewRight = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        viewRight.backgroundColor = UIColor.clearColor()
        viewAboutUs.addSubview(viewRight)
        
        
        width = viewRight.frame.width-3
        height = viewRight.frame.size.height/5-5
        xAxis = 0
        yAxis = 0
        
        let lblTitle_DescOne = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle_DescOne.text = "List of theatres based on your local area based on location."
        lblTitle_DescOne.numberOfLines = 5
        lblTitle_DescOne.textColor = UIColor.whiteColor()
        lblTitle_DescOne.textAlignment = .Left
        lblTitle_DescOne.font = UIFont(name: "HelveticaNeue", size: 13.0)
        viewRight.addSubview(lblTitle_DescOne)
        
        
        width = viewRight.frame.width-3
        height = viewRight.frame.size.height/5-5
        xAxis = 0
        yAxis = lblTitle_DescOne.frame.size.height+lblTitle_DescOne.frame.origin.y+2
        
        let btnTitle_DescTwo = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        btnTitle_DescTwo.text = "View show times for cinema."
        btnTitle_DescTwo.numberOfLines = 5
        btnTitle_DescTwo.textColor = UIColor.whiteColor()
        btnTitle_DescTwo.textAlignment = .Left
        btnTitle_DescTwo.font = UIFont(name: "HelveticaNeue", size: 13.0)
        viewRight.addSubview(btnTitle_DescTwo)
        
        
        width = viewRight.frame.width-3
        height = viewRight.frame.size.height/5-5
        xAxis = 0
        yAxis = btnTitle_DescTwo.frame.size.height+btnTitle_DescTwo.frame.origin.y+2
        
        let btnTitle_DescThree = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        btnTitle_DescThree.text = "Links to book your tickets through the app."
        btnTitle_DescThree.numberOfLines = 5
        btnTitle_DescThree.textColor = UIColor.whiteColor()
        btnTitle_DescThree.textAlignment = .Left
        btnTitle_DescThree.font = UIFont(name: "HelveticaNeue", size: 13.0)
        viewRight.addSubview(btnTitle_DescThree)
        
        
        width = viewRight.frame.width-3
        height = viewRight.frame.size.height/5-5
        xAxis = 0
        yAxis = btnTitle_DescThree.frame.size.height+btnTitle_DescThree.frame.origin.y+2
        
        let btnTitle_DescFour = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        btnTitle_DescFour.text = "Write reviews about movies & share them in social media."
        btnTitle_DescFour.numberOfLines = 5
        btnTitle_DescFour.textColor = UIColor.whiteColor()
        btnTitle_DescFour.textAlignment = .Left
        btnTitle_DescFour.font = UIFont(name: "HelveticaNeue", size: 13.0)
        viewRight.addSubview(btnTitle_DescFour)
        
        
        width = viewRight.frame.width-3
        height = viewRight.frame.size.height/5-5
        xAxis = 0
        yAxis = btnTitle_DescFour.frame.size.height+btnTitle_DescFour.frame.origin.y+2
        
        let btnTitle_DescFive = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        btnTitle_DescFive.text = "Know more information about upcoming movies."
        btnTitle_DescFive.numberOfLines = 5
        btnTitle_DescFive.textColor = UIColor.whiteColor()
        btnTitle_DescFive.textAlignment = .Left
        btnTitle_DescFive.font = UIFont(name: "HelveticaNeue", size: 13.0)
        viewRight.addSubview(btnTitle_DescFive)
        
    }
    
    
    //MARK: - Table view design
    func designTableVeiw() {
        //Designing table view
        let width:CGFloat = viewMain.frame.width
        let height:CGFloat = viewMain.frame.size.height-(viewProfile.frame.origin.y+viewProfile.frame.size.height+64)
        let xAxis:CGFloat = 0
        let yAxis:CGFloat = viewProfile.frame.origin.y+viewProfile.frame.size.height
        
        tableViewSettings = UITableView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height), style: UITableViewStyle.Plain)
        tableViewSettings.tag = 1
        tableViewSettings.layoutSubviews()
        tableViewSettings.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableViewSettings.allowsMultipleSelectionDuringEditing = false
        tableViewSettings.delegate = self
        tableViewSettings.dataSource = self
        tableViewSettings.backgroundColor = UIColor.clearColor()//UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
        tableViewSettings.separatorStyle = UITableViewCellSeparatorStyle.None
        tableViewSettings.showsVerticalScrollIndicator = false
        tableViewSettings.showsHorizontalScrollIndicator = false
        tableViewSettings.rowHeight = 50;
        tableViewSettings.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        viewMain.addSubview(tableViewSettings)
        
        
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(100000000 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            print("table reload called")
//            self.tableViewSettings.reloadData()
        }
        
    }
    
    
        
        
        
        
    //MARK: table view delegate/data source
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "MoviesTableViewCell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil{
        cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        
        
        let viewBackgroundCell = UIView(frame: CGRect(x: 0, y: 0, width: tableViewSettings.frame.size.width, height: 48))
        viewBackgroundCell.backgroundColor = UIColor.clearColor()
        cell.contentView.addSubview(viewBackgroundCell)
        
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let strItem_ = arrayLocations[(indexPath as NSIndexPath).row]
        
        if strItem_ is String{
        
            cell.textLabel?.text = arrayLocations[(indexPath as NSIndexPath).row] as? String
        }
        else{
            let dictLocationItem = arrayLocations[(indexPath as NSIndexPath).row] as! NSDictionary
            cell.textLabel?.text = dictLocationItem.valueForKey( "Location_Name") as? String
        }
        
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        
        return cell!
    }
    
    
    // number of rows in table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLocations.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let dictLocationItem = arrayLocations[(indexPath as NSIndexPath).row] as! NSDictionary
        print("Selected item: \((indexPath as NSIndexPath).row)  withItem: \(dictLocationItem)")
        
        let userDefaults = UserDefaultsStore.userDefaults
        userDefaults.setValue(dictLocationItem, forKey: "Location_ID")
        userDefaults.synchronize()
        
        btnSelectedLocation?.setTitle(dictLocationItem.valueForKey( "Location_Name") as? String, forState: UIControlState())
        
        if isSearchNotTapped == true{
            searchCancelTapped(nil)
        }
        
    }
    
    //MARK: - TextField Delegate and DataSource
    func textFieldDidBeginEditing(textField: UITextField) {
        searchTapped(nil)
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        print("replacementString: \(string)")
        
        if string.characters.count == 0{
            let searchString_ = searchString.substringToIndex(searchString.endIndex.predecessor())
            
//            let searchString_ = searchString.substring(to: searchString.characters.index(before: searchString.endIndex))
            searchString = searchString_
        }
        else{
            searchString = searchString + string
        }
        
        
        print("Appended string: \(searchString)")
        
        let predicate_ = NSPredicate(format: "city contains[c] %@", searchString)
        let aryLoc = arrayLocationsCache.filteredArrayUsingPredicate(predicate_) as NSArray
        
        
        if aryLoc.count == 0{
            
            if searchString.characters.count == 0{
                
                self.arrayLocations.removeAllObjects()
                self.arrayLocations.addObjectsFromArray(self.arrayLocationsCache as [AnyObject])
            }
            else{
                
                self.arrayLocations.removeAllObjects()
                self.arrayLocations.addObject("No Results Found")
            }
        }
        else{
            
            self.arrayLocations.removeAllObjects()
            self.arrayLocations.addObjectsFromArray(aryLoc as [AnyObject])
        }
        
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tableViewLocations.reloadData()
        }

        return true
    }
    
    //MARK: - CoreLocation Delegate
    func fetchCurrentLocation() {
        
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.startUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        print("Didupdate to location: \(locations)")
        
        if !isLocationLoaded{
            isLocationLoaded = true
            
            var currentLocation = CLLocation()
            currentLocation = locations[0]
            
            let locationDetails: CLLocation = self.locationInLocations(self.arrayLatAndLongs, closestToLocation: currentLocation)!
            
            let nearestLat = String(locationDetails.coordinate.latitude)
            let nearestLong = String(locationDetails.coordinate.longitude)
            
            print("Nearest lat: \(currentLocation.coordinate.latitude) and long: \(currentLocation.coordinate.longitude) \(locationDetails)")
            
            print("Storing the current location")
            
            for (index, key) in arrayLocations.enumerate(){
                let dictLocationItem = arrayLocations[index] as! NSDictionary
                print("Locations: \(dictLocationItem)")
                
                let lat_movie = String(dictLocationItem.valueForKey("Latitude")!)
                let long_movie = String(dictLocationItem.valueForKey("Longitude")!)
                
                if nearestLat == lat_movie && nearestLong == long_movie {
                    
                    let userDefaults = UserDefaultsStore.userDefaults
                    userDefaults.setValue(dictLocationItem, forKey: "Location_ID")
                    userDefaults.synchronize()
                    
                    btnSelectedLocation?.setTitle(dictLocationItem.valueForKey( "Location_Name") as? String, forState: UIControlState())
                    
                }
                
            }
        }
    }
    
    //MARK: - Fetching nearest location
    func locationInLocations(locations: NSArray, closestToLocation location_closestTo: CLLocation) -> CLLocation? {
        
        
        var closestLocation = CLLocation()
        
        var smallestDistance = CLLocationDistance()
        smallestDistance = DBL_MAX
        
        for location_ in locations{
            let location: CLLocation = location_ as! CLLocation
            let distance: CLLocationDistance = location_closestTo.distanceFromLocation(location)
            
            if (distance < smallestDistance) {
                smallestDistance = distance
                closestLocation = location
            }
            
        }
        
        //        for (CLLocation *location in locations) {
        //            CLLocationDistance distance = [location_closestTo distanceFromLocation:location];
        //
        //            if (distance < smallestDistance) {
        //                smallestDistance = distance;
        //                closestLocation = location;
        //            }
        //        }
        
        //        if locations.count == 0 {
        //            return nil
        //        }
        //
        //        var closestLocation: CLLocation?
        //        var smallestDistance: CLLocationDistance?
        //
        //        for location in locations {
        //            let distance = location.distanceFromLocation(location)
        //            if smallestDistance == nil || distance < smallestDistance {
        //                closestLocation = location
        //                smallestDistance = distance
        //            }
        //        }
        
//        print("closestLocation: \(closestLocation), distance: \(smallestDistance)")
        return closestLocation
    }
    
    
    
    
    //MARK: - Button Event
    
    func callEvent(sender:UIButton) {
        print("Call event")
    }
    
    func emailEvent(sender:UIButton) {
        print("emailEvent event")
    }
    
    func webEvent(sender:UIButton) {
        print("webEvent event")
    }
    
    func moreAppEvent(sender:UIButton) {
        print("moreAppEvent event")
    }
    
    func shareEvent(sender:UIButton) {
        print("Share button event")
        
        let textToShare = "Share City Movies!"
        
        if let myWebsite = NSURL(string: "https://itunes.apple.com/in/app/amar-masjid/id1111603613?mt=8") {
            let objectsToShare = [textToShare, myWebsite] as [AnyObject]

            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
//            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypeAddToReadingList];
            
            activityVC.popoverPresentationController?.sourceView = self.view
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    
    func rateThisAppEvent(sender:UIButton) {
        print("Rate this app event")
        
        if let url = NSURL(string: "https://itunes.apple.com/in/app/amar-masjid/id1111603613?mt=8") {
            UIApplication.sharedApplication().openURL(url)
        }
        else{
            print("Cannot open the url")
        }
        
    }
    
    func feedBackEvent(sender:UIButton) {
        print("Rate this app event")
        
        let viewController = FeedBackViewController(justInit: NSDictionary())
        viewController.navigCRefFeedback = self.navigRefe
        viewController.controlRefFeedback = controlRefe
        self.navigRefe!.pushViewController(viewController, animated: true)
        
    }
    
    func searchCancelTapped(sender: UIButton?) {
        print("Search cancelled")
        
        isSearchNotTapped = false
        
        UIView.animateWithDuration( 0.3, animations: {() -> Void in
            
            self.searchString = ""
            
            self.arrayLocations.removeAllObjects()
            self.arrayLocations.addObjectsFromArray(self.arrayLocationsCache as [AnyObject])
            
            self.tableViewLocations.reloadData()
            
            self.textFieldSearch.resignFirstResponder()
            self.textFieldSearch.text = ""
            
            self.viewMain.transform = CGAffineTransformIdentity
            
            self.viewForSearch.frame = CGRect(x: (self.scrollViewForDesigns.frame.width/3-13)-30, y: self.viewForSearch.frame.origin.y, width: self.viewForSearch.frame.size.width, height: self.viewForSearch.frame.size.height)
            
            self.tableViewLocations.frame = CGRect(x: (self.scrollViewForDesigns.frame.width/3-13)-10, y: self.tableViewLocations.frame.origin.y, width: self.tableViewLocations.frame.size.width, height: self.tableViewLocations.frame.size.height-40)
            
            self.viewLine.frame = CGRect(x: self.viewLine.frame.origin.x, y: self.viewLine.frame.origin.y, width: self.scrollViewForDesigns.frame.width/2, height: self.viewLine.frame.size.height)
            
            self.textFieldSearch.frame = CGRect(x: self.textFieldSearch.frame.origin.x, y: self.textFieldSearch.frame.origin.y, width: self.textFieldSearch.frame.width-100, height: self.textFieldSearch.frame.size.height)
            
            self.imgSearchIcon.hidden = false
        })
        
    }
    
    func searchTapped(sender: UIButton?) {
        print("Search tapped")
        
        isSearchNotTapped = true
        
        UIView.animateWithDuration( 0.3, animations: {() -> Void in
          
            self.searchString = ""
            
            self.viewMain.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -(self.scrollViewForDesigns.frame.origin.y))
            
            self.tableViewLocations.frame = CGRect(x: 20, y: self.tableViewLocations.frame.origin.y, width: self.tableViewLocations.frame.size.width, height: self.tableViewLocations.frame.size.height+40)
            
            self.viewForSearch.frame = CGRect(x: 0, y: self.viewForSearch.frame.origin.y, width: self.viewForSearch.frame.size.width, height: self.viewForSearch.frame.size.height)
            
            self.viewLine.frame = CGRect(x: self.viewLine.frame.origin.x, y: self.viewLine.frame.origin.y, width: self.scrollViewForDesigns.frame.width, height: self.viewLine.frame.size.height)
            
            self.textFieldSearch.frame = CGRect(x: self.textFieldSearch.frame.origin.x, y: self.textFieldSearch.frame.origin.y, width: self.textFieldSearch.frame.width+100, height: self.textFieldSearch.frame.size.height)
            
            self.imgSearchIcon.hidden = true
        })
    }
    
    //MARK: - AlertView delegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1{
            print("Call")
            
            if let url = NSURL(string: "tel://+447453289655") {
                UIApplication.sharedApplication().openURL(url)
            }
            else{
                print("Telephone service not available")
            }
        }
        else{
            print("Cancel")
        }
    }
    
    //MARK: - Settings
    func settingsEvent(sender:UIButton){
        print("Settings event")
    }
    
    func aboutEvent(sender:UIButton){
        print("About event")
    }
    
    //MARK: - Services part
    func getLocations() {
        
        //Adding activity view to self.view
//        if ARSLineProgress.shown { return }
//        ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
//            
//        }
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        appDelegate.window?.userInteractionEnabled = false
        //        viewMain.userInteractionEnabled = false
        
        print("Getting locations list")
        
        let url_ = NSURL(string: "http://citymoviesapi.bananaapps.co.in/api/Location/LocationDetails")
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
                            //print("\(json)")
                            
                            let json_array_locations = json.valueForKey("Mloc") as! NSArray
                            
                            if let json = json_array_locations as? NSArray {
                                
                                self.arrayLocationsCache.removeAllObjects()
                                
                                for item_ in json {
                                    let dictMutable = NSMutableDictionary()
                                    
                                    let obj = item_ as! NSDictionary
                                    for (key, value) in obj {
                                        dictMutable.setValue(value, forKey: key as! String)
                                    }
                                    
                                    let lat = dictMutable.valueForKey("Latitude") as! String
                                    let long = dictMutable.valueForKey("Longitude") as! String
                                    
                                    
                                    let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double((lat as NSString).doubleValue), longitude: Double((long as NSString).doubleValue))
                                    
                                    let locationObj: CLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                                    self.arrayLatAndLongs.addObject(locationObj)
                                    
                                    self.arrayLocationsCache.addObject(dictMutable)
                                }
                            }
                            
                            if self.arrayLatAndLongs.count > 0{
                                self.fetchCurrentLocation()
                            }
                            
                            print("Got all the locations array list")
                            
                            self.arrayLocations.removeAllObjects()
                            self.arrayLocations.addObjectsFromArray(self.arrayLocationsCache as [AnyObject])
                            
                            //                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                            //                        let locationsList = appDelegate.getValues("Locations")
                            //                        if locationsList.count > 0{
                            //                            appDelegate.deleteEntity("Locations")
                            //                        }
                            
                            //                        for movie in self.arrayLocations{
                            //                            appDelegate.setValuesToEntity("Locations", withDictionary: movie as! NSDictionary)
                            //                        }
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                self.tableViewLocations.reloadData()
                            }
                            
                            
                            
                        } else if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
                            // process "json" as an array
                            
                            
                            
                        } else {
                            //                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                            //                        print("Error could not parse movies JSON string: \(jsonStr)")
                            
                            print("Error could not parse movies JSON string:")
                        }
                        
                    } catch {
                        print("error serializing location JSON: \(error)")
                    }
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    //                appDelegate.window?.userInteractionEnabled = true
                    //                //                viewMain.userInteractionEnabled = true
                    //                ARSLineProgress.hideWithCompletionBlock({ () -> Void in
                    //                    print("Hidden location with completion block")
                    //                })
                }
                
            }
            
        });
        
        // do whatever you need with the task e.g. run
        task.resume()
        
    }
    
    //MARK: - Get values from coredata
    func getValuesFromCoreData_Locations() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let aryEntityValues:NSArray = appDelegate.getValues("Locations")
        
        if aryEntityValues.count > 0{
            
            for dicti in aryEntityValues{
                
                let locations_obj:Locations = dicti as! Locations
                
                let locations_DictObj = NSMutableDictionary()
                locations_DictObj.setValue(locations_obj.city, forKey: "Location_Name")
                locations_DictObj.setValue(locations_obj.latitude, forKey: "Latitude")
                locations_DictObj.setValue(locations_obj.longitude, forKey: "Longitude")
                locations_DictObj.setValue(locations_obj.lid, forKey: "Location_ID")
                locations_DictObj.setValue(locations_obj.state, forKey: "State")
                
                self.arrayLocationsCache.addObject(locations_DictObj)
                self.arrayLocations.addObject(locations_DictObj)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                print("Made a movies reload request: In side main thread. Fetching from coredata")
                self.tableViewLocations.reloadData()
                
                self.getLocations()
            }
        }
        else{
            
//            let delayTime = DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
//            DispatchQueue.main.asyncAfter(deadline: delayTime) {
//                self.getLocations()
//            }
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                print("table reload called")
                self.getLocations()
            }
            
            
            
            //            dispatch_async(dispatch_get_main_queue(),{
            //
            //            })
        }
    }
    
    
    
    //MARK: - Logout Event
    func logoutEvent(sender: AnyObject) {
        print("Logout event")
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
        
        UserDefaultsStore.deleteUserName("", password: "")
        
        controlRefe?.navigationController?.popViewControllerAnimated(true);
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
