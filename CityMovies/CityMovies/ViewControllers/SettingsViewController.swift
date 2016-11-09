//
//  SettingsViewController.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 31/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit
import MessageUI


class SettingsViewController: UIViewController , UITableViewDelegate,UITableViewDataSource, MFMailComposeViewControllerDelegate{
    
    //MARK: - Check and remove if necessary
    var navigRef : UINavigationController?
    var controlRef : SLPagingViewSwift?
    let optionNames = [("Share This App","Share This App"), ("Rate This App","Rate This App"), ("Feedback","Feedback"), ("Contact us","Contact us"), ("About us","About us")]
    
    var mailComposer : MFMailComposeViewController?
    
    //MARK: - ViewController LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigRef?.navigationBarHidden = true
        
        
        navigRef?.navigationItem.backBarButtonItem = nil
        navigRef?.navigationItem.hidesBackButton = true
        var item = navigRef?.navigationBar.backItem
        item = nil
        
        navigRef?.navigationBarHidden = true
        navigRef?.navigationItem.hidesBackButton = true
        navigRef?.navigationItem.hidesBackButton = true
        navigRef?.navigationBar.barTintColor = UIColor.blackColor()
        
        
        var xAxis : CGFloat = 0
        var yAxis : CGFloat = 0
        var width : CGFloat = self.view.bounds.width
        var height : CGFloat = self.view.bounds.height
        
        
        let backgroundImageView = UIImageView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        backgroundImageView.image = UIImage(named: "sidemenubg")
        let reqColor = UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue:72/255.0, alpha: 0.9)
        view.addSubview(backgroundImageView)
        
        height = 64
        
        let headerView : UIView = UIView(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        headerView.backgroundColor = reqColor
        
        yAxis = headerView.frame.size.height/2
        let backButton = UIButton(type: .Custom)
        backButton.frame = CGRect(x: xAxis, y: yAxis, width: 30, height: 30)
        backButton.setImage(UIImage(named: "Arrow_left"), forState: UIControlState())
        backButton.userInteractionEnabled = true
        backButton.backgroundColor = UIColor.clearColor()
        backButton.addTarget(self, action: #selector(SettingsViewController.dismissVC), forControlEvents: .TouchUpInside)
        headerView.addSubview(backButton)
        
        xAxis = headerView.frame.midX - 40
        yAxis = headerView.frame.midY
        let titleLabel = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: 80,height: 30))
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.text = "Settings"
        titleLabel.textColor = UIColor.whiteColor()
        headerView.addSubview(titleLabel)
        
        view.addSubview(headerView)
        
        xAxis = 0
        yAxis =  headerView.bounds.height
        width = self.view.bounds.width
        height = self.view.bounds.height - yAxis
        
        let tableView : UITableView = UITableView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height), style: .Plain)
        tableView.backgroundColor = reqColor
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.userInteractionEnabled = true
        tableView.separatorColor = UIColor.whiteColor()
        tableView.tableFooterView = UIView(frame : CGRect.zero)
        self.view.addSubview(tableView)
        
        
    }
    
    //MARK: - tableview delegate and datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionNames.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "SettingsTableViewCell"
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil{
            
            cell = UITableViewCell(style:.Default, reuseIdentifier: identifier)
        }
        cell?.imageView?.image = UIImage(named: optionNames[(indexPath as NSIndexPath).row].1)
        cell?.textLabel?.text = optionNames[(indexPath as NSIndexPath).row].0
        cell?.textLabel?.textColor = UIColor.whiteColor()
        cell?.backgroundColor = UIColor.clearColor()
        return cell!
    }
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func dismissVC() {
        
        navigRef?.navigationBar.hidden = false
        navigRef?.navigationBarHidden = false
        navigRef!.popToViewController(controlRef!, animated: true)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if (indexPath as NSIndexPath).row == 0 {
            let developerWebsite = "CityMovies"
            let appURL = NSURL(string: "http://www.google.com")
            
            let objectsTOShare : NSArray = [developerWebsite,appURL!]
            let activityViewController = UIActivityViewController(activityItems: objectsTOShare as [AnyObject], applicationActivities: nil)
            
            if #available(iOS 9.0, *) {
                
                activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypeOpenInIBooks, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList, UIActivityTypeSaveToCameraRoll, UIActivityTypeCopyToPasteboard, UIActivityTypePostToTencentWeibo, UIActivityTypePostToWeibo]
            } else {
                // Fallback on earlier versions
            }
            self.presentViewController(activityViewController, animated: true, completion: nil)
        }  else if (indexPath as NSIndexPath).row == 1 {
            print("show ratings screen no design available")
        } else if (indexPath as NSIndexPath).row == 2 {
            print("show feedback page")
            if !MFMailComposeViewController.canSendMail() {
                print("mail app is not set up in the device")
                let alertController = UIAlertController(title: "Mail App Not Configured", message: "Pls add the Username and password for Mail App", preferredStyle: .ActionSheet)
                let action1 = UIAlertAction(title: "Want to Setup Mail", style:.Default, handler: { (_) in
                    UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                })
                let action2 = UIAlertAction(title: "cancel", style: .Cancel, handler: nil)
                alertController.addAction(action1)
                alertController.addAction(action2)
            } else {
                
                mailComposer = MFMailComposeViewController()
                mailComposer!.mailComposeDelegate = self
                mailComposer!.setToRecipients(["phanikumar.kaligi@gmail.com"])
                mailComposer!.setSubject("Feedback")
                mailComposer!.setMessageBody("Hello , feedback here", isHTML: false)
                self.presentViewController(mailComposer!, animated: true, completion: nil)
                
            }
        } else if (indexPath as NSIndexPath).row == 3 {
            print("contact us - no design available")
        } else if (indexPath as NSIndexPath).row == 4 {
            print("about us page - design not available")
        }
        
    }
    
    //MARK:- Mail Composer Delegate methods
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: NSError?) {
        
        
        if result == MFMailComposeResult.Cancelled {
            let alertController = UIAlertController(title: "Sending Failed", message: "Feedback not submitted", preferredStyle: .Alert)
            let action1 = UIAlertAction(title: "OK", style: .Default, handler: { (_) in
                controller.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(action1)
            presentViewController(alertController, animated: true, completion: nil)
        } else if result == MFMailComposeResult.Sent {
            let alertController = UIAlertController(title: "Feedback Submitted", message: "Thanks For Your Feedback", preferredStyle: .Alert)
            let action1 = UIAlertAction(title: "Done", style: .Default, handler: { (_) in
                controller.dismissViewControllerAnimated(true, completion: nil)
            })
            
            alertController.addAction(action1)
            presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    
}


