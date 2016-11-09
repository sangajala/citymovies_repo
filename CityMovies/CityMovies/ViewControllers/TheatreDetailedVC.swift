//
//  TheatreDetailedVC.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 13/07/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit

class TheatreDetailedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var movie : NSDictionary!
    var tableViewBookings = UITableView()
    var arrayBookingsList = NSArray()
    var theaterNameTapped = NSString()
    
    var navigCRefe : UINavigationController?
    var controlCRefe : SLPagingViewSwift?
    var navigView = UIView()
    
    var bookingScreen : UIViewController = UIViewController()
    var delegate : WebViewProtocol_?
    
    //MARK: - ViewController code starts here
    init ( justInit : NSDictionary ) {
        
        self.movie = justInit
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Arry bookings list: \(arrayBookingsList)")
        
        navigCRefe?.navigationBarHidden = true
        
        self.view.backgroundColor = UIColor.clearColor()
        
        var width : CGFloat = self.view.frame.width
        var height : CGFloat = self.view.frame.height
        var xAxis : CGFloat = 0
        var yAxis : CGFloat = 0
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "loginBackground")?.drawInRect( self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor.init(patternImage: image!)
        
        
        // navigationBar
        height = 64
        navigView = UIView(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        
        //        height = 40
        //        width = 40
        //        xAxis = 0
        //        yAxis = navigView.bounds.height/2 - 15
        
        
        height = 30
        width = 30
        xAxis = 10
        yAxis = 20 + ((navigView.frame.size.height-20)/2-height/2)
        
        let btnBack = UIButton(type: .Custom)
        btnBack.frame = CGRect(x: xAxis,y: yAxis,width: width,height: height)
        btnBack.userInteractionEnabled = true
        btnBack.setImage(UIImage(named: "Arrow_left"), forState: UIControlState())
        btnBack.tintColor = UIColor.whiteColor()
        btnBack.addTarget(self, action: #selector(TheatreDetailedVC.dismissVC), forControlEvents: .TouchUpInside)
        navigView.addSubview(btnBack)
        navigView.backgroundColor = UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
        view.addSubview(navigView)
        
        width = navigView.frame.size.width-(btnBack.frame.size.width*2+50)
        xAxis = navigView.frame.size.width/2-width/2
        yAxis = btnBack.frame.origin.y
        height = 30
        
        let lblMovieDetails = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        lblMovieDetails.backgroundColor = UIColor.clearColor()
        lblMovieDetails.text = theaterNameTapped as String
        lblMovieDetails.font = UIFont(name: "Helvetica Neue", size: 15)
        lblMovieDetails.textColor = UIColor.whiteColor()
        lblMovieDetails.textAlignment = NSTextAlignment.Center
        navigView.addSubview(lblMovieDetails)
        
        designTableVeiw()
    }
    
    //MARK: - Table view design
    func designTableVeiw() {
        //Designing table view
        let width:CGFloat = self.view.frame.width
        let height:CGFloat = self.view.frame.size.height-(64)
        let xAxis:CGFloat = 0
        let yAxis:CGFloat = 64
        
        tableViewBookings = UITableView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height), style: UITableViewStyle.Plain)
        tableViewBookings.tag = 1
        tableViewBookings.layoutSubviews()
        tableViewBookings.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableViewBookings.allowsMultipleSelectionDuringEditing = false
        tableViewBookings.delegate = self
        tableViewBookings.dataSource = self
        tableViewBookings.backgroundColor = UIColor.clearColor()//UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
        tableViewBookings.separatorStyle = UITableViewCellSeparatorStyle.None
        tableViewBookings.showsVerticalScrollIndicator = false
        tableViewBookings.showsHorizontalScrollIndicator = false
        tableViewBookings.rowHeight = 50;
        tableViewBookings.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableViewBookings)
        
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(100000000 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            print("table reload called")
            self.tableViewBookings.reloadData()
        }
    }
    
    
    //MARK: - Table delegate and data source
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "TheatresTableViewCell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier)
        
        if cell == nil{
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
            
            
            let viewBackgroundCell = UIView(frame: CGRect(x: 10, y: 48, width: tableViewBookings.frame.size.width, height: 1))
            viewBackgroundCell.backgroundColor = UIColor.init(white: 1, alpha: 0.7)
            cell.contentView.addSubview(viewBackgroundCell)
            
            let lblBook = UILabel(frame: CGRect(x: tableViewBookings.frame.size.width-90, y: 5, width: 80, height: 40))
            lblBook.text = "Book Now"
            lblBook.textColor = UIColor.whiteColor()
            lblBook.textAlignment = .Center
            lblBook.backgroundColor = UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
            lblBook.font = UIFont(name: "Helvetica Neue", size: 14)
            lblBook.layer.cornerRadius = 5.0
            lblBook.clipsToBounds = true
            cell.contentView.addSubview(lblBook)
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let dictItem = arrayBookingsList[(indexPath as NSIndexPath).row] as! NSDictionary
        
        
        let strCity = "\(dictItem.valueForKey( "BookingSiteName"))"
        let strLogoURL = "\(dictItem.valueForKey( "Logo"))"
        
//        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
//            print(self)
//        }
        
        var strCityString:String = String(format: "%@", strCity)
        if strCityString.containsString("Optional("){
            strCityString = strCityString.stringByReplacingOccurrencesOfString("Optional(", withString: "")
        }
        if strCityString.containsString(")"){
            strCityString = strCityString.stringByReplacingOccurrencesOfString(")", withString: "")
        }
        
        var strLogoString:String = String(format: "%@", strLogoURL)
        if strLogoString.containsString("Optional("){
            strLogoString = strLogoString.stringByReplacingOccurrencesOfString("Optional(", withString: "")
        }
        if strLogoString.containsString(")"){
            strLogoString = strLogoString.stringByReplacingOccurrencesOfString(")", withString: "")
        }
        
//        let url = NSURL(string: strLogoString)
//        //        cell.imgViewMovies.sd_setImageWithURL(url, completed: block)
//        let imgPlaceholder = UIImage(named: "placeholder_movie")
//        cell.imageView!.sd_setImageWithURL(url, placeholderImage: imgPlaceholder, completed: block)
        
        cell.imageView?.layer.cornerRadius = 7.0
        cell.imageView?.clipsToBounds = true
        cell.imageView?.contentMode = .ScaleAspectFit
        
        cell.textLabel?.text = strCityString
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell!
    }
    
    
    
    // number of rows in table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayBookingsList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected item: \((indexPath as NSIndexPath).row)  withItem: \(arrayBookingsList[(indexPath as NSIndexPath).row])")
        
        
        let dictItem = arrayBookingsList[(indexPath as NSIndexPath).row] as! NSDictionary
        let strURL = "\(dictItem.valueForKey( "URL"))"
        
        var strLogoString:String = String(format: "%@", strURL)
        if strLogoString.containsString("Optional("){
            strLogoString = strLogoString.stringByReplacingOccurrencesOfString("Optional(", withString: "")
        }
        if strLogoString.containsString(")"){
            strLogoString = strLogoString.stringByReplacingOccurrencesOfString(")", withString: "")
        }
        
        presentBookingView(strLogoString)
    }
    
//    //MARK: - WebView related
//    
//    func displayWebView ( string : String) {
//        self.delegate?.presentBookingView!(string)
//    }
//    
//    func  cancel() -> () {
//        delegate?.cancelEvent(bookingScreen)
//    }
    
    //MARK:- WebViewProtocol Methods
    
//    func presentWebView(vc : UIViewController) {
//        presentViewController(vc, animated: true, completion: nil)
//    }
//    
//    func cancelEvent(vc : UIViewController) {
//        vc.dismissViewControllerAnimated(true, completion: nil)
//    }
    
    func presentBookingView(str: String) {
        let bookingVC = BookingScreenViewController(string: str)
        presentViewController(bookingVC, animated: true, completion: nil)
    }
    
    //MARK: - Dissmiss VC
    func dismissVC () {
        navigCRefe?.navigationBar.hidden = false
        navigCRefe?.navigationBarHidden = false
        navigCRefe!.popToViewController(controlCRefe!, animated: true)
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
