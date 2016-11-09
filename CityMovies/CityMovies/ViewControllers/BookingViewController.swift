//
//  BookingViewController.swift
//  CityMovies
//
//  Created by Deepthi Kaligi on 20/05/2016.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , WebViewProtocol_{
    
    var movie : NSDictionary!
    var photoURlsArray = NSMutableArray()
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var moviePoster : UIImageView!
    var navigRef : UINavigationController?
    var movieTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if (photoURlsArray.count != 0){
            
            if let poster = UIImage(data: NSData(contentsOfURL: NSURL(string: photoURlsArray[0] as! String)!)!) {
                moviePoster.image = poster
            }
        }
        
        // Do any additional setup after loading the view.
        
    }
    
    
    
    //MARK: - TableView Datasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return photoURlsArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : BookingTableViewCell!
        if let reusableCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? BookingTableViewCell {
            reusableCell.movieTitle.text = self.movieTitle
            reusableCell.bookButton.tag = (indexPath as NSIndexPath).section
            reusableCell.bookButton.layer.cornerRadius = 3.0
            reusableCell.bookButton.clipsToBounds = true
            reusableCell.delegate = self
            
            
            cell = reusableCell
            
            
            //do the coding once you get the API for the Gateways
        }
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerString : String
        if section == 0 {
            headerString = "Justtickets logo (not available)"
        } else if section == 1 {
            headerString = "paypal logo (not available)"
        } else {
            headerString = "bookmyshow logo (not available)"
        }
        
        let headerView : UIView = UIView(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width , height: self.tableView(tableView, heightForHeaderInSection: section)))
        headerView.backgroundColor = UIColor.grayColor()
        let label : UILabel = UILabel(frame : CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 30))
        label.textAlignment = .Center
        label.font = UIFont(name: "New Times Roman", size: 22)
        label.text = headerString
        label.center = headerView.center
        label.textColor = UIColor.whiteColor()
        headerView.addSubview(label)
        //        let myCustomView: UIImageView = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width , self.tableView(tableView, heightForHeaderInSection: section)))
        //        myCustomView.contentMode = UIViewContentMode.ScaleAspectFit
        //        myCustomView.clipsToBounds = true
        //        let myImage: UIImage = UIImage(named: headerString)!
        //        myCustomView.image = myImage
        //        headerView.addSubview(myCustomView)
        return headerView
        
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95
    }
    
    
    
    //MARK: - Dismiss This View
    
    @IBAction func dismissVC() {
        navigRef?.popViewControllerAnimated(true)
    }
    
    
    //MARK:- WebViewProtocol Methods
    
    func presentWebView(vc : UIViewController) {
        presentViewController(vc, animated: true, completion: nil)
    }
    
    func cancelEvent(vc : UIViewController) {
        vc.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentBookingView(str: String) {
        let bookingVC = BookingScreenViewController(string: str)
        presentViewController(bookingVC, animated: true, completion: nil)
    }
    
}
