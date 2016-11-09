//
//  BookVC.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 23/10/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit
import WebKit
import Kingfisher

class BookVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var navigRef : UINavigationController?
    
    @IBOutlet var imgViewMovie: UIImageView!
    @IBOutlet var lblMovieTitle: UILabel!
    @IBOutlet var lblCastDetails: UILabel!
    @IBOutlet var lblTimeDate: UILabel!
    
    @IBOutlet var viewRatingOne: UIView!
    @IBOutlet var viewRatingTwo: UIView!
    @IBOutlet var viewRatingThree: UIView!
    @IBOutlet var viewRatingFour: UIView!
    
    @IBOutlet var lblRatingOne: UILabel!
    @IBOutlet var lblRatingTwo: UILabel!
    @IBOutlet var lblRatingThree: UILabel!
    @IBOutlet var lblRatingFour: UILabel!
    
    
    @IBOutlet var lblTitleRatingOne: UILabel!
    @IBOutlet var lblTitleRatingTwo: UILabel!
    @IBOutlet var lblTitleRatingThree: UILabel!
    @IBOutlet var lblTitleRatingFour: UILabel!
    
    @IBOutlet var tableViewBookings: UITableView!
    
    var arrayMovieBookingList = NSArray()
    var movie = NSDictionary()

    var layoutConstraint_ = NSLayoutConstraint()
    
    var bookingScreen : UIViewController = UIViewController()
    
    //MARK: - ViewController LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

//        print("Movie details: \(arrayMovieBookingList)")
        print("Movie details: \(self.movie)")
        
        // Do any additional setup after loading the view.
        
        if let moviesDetails = self.movie.valueForKey("Mov_Image"){
            
            print("Movies details received: \(moviesDetails)")
            self.configureViewCircles()
            self.configureViewDetails()
        }
        else{
            self.tableViewBookings.translatesAutoresizingMaskIntoConstraints = true
            self.tableViewBookings.frame = CGRectMake(self.tableViewBookings.frame.origin.x, 60, self.view.frame.size.width-30, 400)
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    func configureViewDetails(){
        
//        let strItem = photoURlsArray[0] as! String
//        //ImagedNeeded
        imgViewMovie.kf_setImageWithURL(NSURL(string: (self.movie["Mov_Image"] as? String)!)!)
        
        lblMovieTitle.text = self.movie["Mov_Name"] as? String
        lblMovieTitle.autoresize()
        
        lblCastDetails.text = self.movie["Movie_Type_Details"] as? String
    }
    
    func configureViewCircles() {
        
        viewRatingOne.layer.borderWidth = 1.0
        viewRatingOne.layer.borderColor = UIColor.init(red: 237/255.0, green: 26/255.0, blue: 81/255.0, alpha: 1.0).CGColor
        viewRatingOne.layer.cornerRadius = 25
    
        viewRatingTwo.layer.borderWidth = 1.0
        viewRatingTwo.layer.borderColor = UIColor.init(red: 237/255.0, green: 26/255.0, blue: 81/255.0, alpha: 1.0).CGColor
        viewRatingTwo.layer.cornerRadius = 25
        
        viewRatingThree.layer.borderWidth = 1.0
        viewRatingThree.layer.borderColor = UIColor.init(red: 237/255.0, green: 26/255.0, blue: 81/255.0, alpha: 1.0).CGColor
        viewRatingThree.layer.cornerRadius = 25
        
        viewRatingFour.layer.borderWidth = 1.0
        viewRatingFour.layer.borderColor = UIColor.init(red: 237/255.0, green: 26/255.0, blue: 81/255.0, alpha: 1.0).CGColor
        viewRatingFour.layer.cornerRadius = 25
        
        
        //Configuring rating circles
        viewRatingOne.hidden = true
        viewRatingTwo.hidden = true
        viewRatingThree.hidden = true
        viewRatingFour.hidden = true
        
        lblRatingOne.hidden = true
        lblRatingTwo.hidden = true
        lblRatingThree.hidden = true
        lblRatingFour.hidden = true
        
        lblTitleRatingOne.hidden = true
        lblTitleRatingTwo.hidden = true
        lblTitleRatingThree.hidden = true
        lblTitleRatingFour.hidden = true
        
        
        let arrayRatings = self.movie.valueForKey("Movierating") as! NSArray
        
        for dictRating_ in arrayRatings{
            
            let dictRating = dictRating_ as! NSDictionary
            let indexOfObj = arrayRatings.indexOfObject(dictRating)
            
            if indexOfObj == 0{
                viewRatingOne.hidden = false
                lblRatingOne.hidden = false
                lblTitleRatingOne.hidden = false
                
                let str_webSiteName = dictRating.valueForKey("WebSite_Name") as! String
                lblTitleRatingOne.text = str_webSiteName
                
                let str_rating = "\(String(dictRating.valueForKey("Rating")!))/\(String(dictRating.valueForKey("Rating_Count")!))"
                lblRatingOne.text = str_rating
            }
            if indexOfObj == 1{
                viewRatingTwo.hidden = false
                lblRatingTwo.hidden = false
                lblTitleRatingTwo.hidden = false
                
                let str_webSiteName = dictRating.valueForKey("WebSite_Name") as! String
                lblTitleRatingTwo.text? = str_webSiteName
                
                let str_rating = "\(String(dictRating.valueForKey("Rating")!))/\(String(dictRating.valueForKey("Rating_Count")!))"
                lblRatingTwo.text = str_rating
            }
            if indexOfObj == 2{
                viewRatingThree.hidden = false
                lblRatingThree.hidden = false
                lblTitleRatingThree.hidden = false
                
                let str_webSiteName = dictRating.valueForKey("WebSite_Name") as! String
                lblTitleRatingThree.text = str_webSiteName
                
                let str_rating = "\(String(dictRating.valueForKey("Rating")!))/\(String(dictRating.valueForKey("Rating_Count")!))"
                lblRatingThree.text = str_rating
            }
            if indexOfObj == 3{
                viewRatingFour.hidden = false
                lblRatingFour.hidden = false
                lblTitleRatingFour.hidden = false
                
                let str_webSiteName = dictRating.valueForKey("WebSite_Name") as! String
                lblTitleRatingFour.text? = str_webSiteName
                
                let str_rating = "\(String(dictRating.valueForKey("Rating")!))/\(String(dictRating.valueForKey("Rating_Count")!))"
                lblRatingFour.text = str_rating
            }
        }
    }
    
    //MARK: table view delegate/data source
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "CellBookDetails"
        
        var cell: BookVCCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? BookVCCell
        if cell == nil{
            
            cell = BookVCCell(style: .Default, reuseIdentifier: identifier)
        }
        
        print("\(arrayMovieBookingList)")
        
        let dictItem = arrayMovieBookingList[(indexPath as NSIndexPath).row] as! NSDictionary
        
        let strURL = dictItem.valueForKey("Logo") as! String
        
        let url = NSURL(string: strURL)
        let imgPlaceholder = UIImage(named: "placeholder_movie")
        //ImagedNeeded
        cell.imgViewBooking.kf_setImageWithURL(url!, placeholderImage: imgPlaceholder, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        
        return cell
    }
    
    
    // number of rows in table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMovieBookingList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("Selected item: \((indexPath as NSIndexPath).row)  withItem: \(photoURlsArray[(indexPath as NSIndexPath).row])")
        
        print("Selected item: \((indexPath as NSIndexPath).row)")
        
        let dictItem = arrayMovieBookingList[(indexPath as NSIndexPath).row] as! NSDictionary
        let strURL = dictItem.valueForKey("URL") as! String
        
        let webView = TOWebViewController(URL: NSURL(string: strURL))
        let navVC = UINavigationController(rootViewController: webView)
        self.presentViewController(navVC, animated: true, completion: nil)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        
//        displayWebView("https://www.justickets.in")
        
    }
    
    //MARK: - Close Event
    @IBAction func closeEvent(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(false)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK: - WebView Delegates/Protocol
//    func displayWebView (string : String) {
//        self.delegate_webView?.presentBookingView!(string)
//    }
//    
//    func  cancel() -> () {
//        delegate_webView?.cancelEvent(bookingScreen)
//    }
    
    
    
//    protocol WebViewProtocol {
//        func  presentWebView(vc : UIViewController)
//        func  cancelEvent(vc : UIViewController) -> ()
//        @objc optional func presentBookingView(str : String)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
