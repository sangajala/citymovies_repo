//
//  BookingScreenViewController.swift
//  CityMovies
//
//  Created by Deepthi Kaligi on 04/07/2016.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit
import WebKit


class BookingScreenViewController: UIViewController {
    
    var webView : WKWebView = WKWebView()
    var string : String

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 0, y: 20, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height-20)
        self.webView = WKWebView(frame: rect)
        webView.loadRequest(NSURLRequest(URL: NSURL(string: self.string)!))
        self.view.addSubview(webView)
        let bottom  = UIView(frame: CGRect(x: 0,y: webView.bounds.origin.y+webView.bounds.size.height-44,width: UIScreen.mainScreen().bounds.width,height: 44))
        bottom.backgroundColor = UIColor.clearColor()
//        bottom.backgroundColor = UIColor(red: 218.0/255.0, green: 143.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        if #available(iOS 9.0, *) {
            webView.allowsLinkPreview = true
        } else {
            // Fallback on earlier versions
        }
        webView.allowsBackForwardNavigationGestures = true
        webView.addSubview(bottom)
        
        let back = UIButton(type: .Custom)
        back.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        back.setImage(UIImage(named: "backarrow"), forState: UIControlState())
      //  back.setTitle("back", forState: .Normal)
        back.imageView?.clipsToBounds = true
        back.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        back.addTarget(self, action: #selector(BookingScreenViewController.backButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        bottom.addSubview(back)
        
        let forward = UIButton(type: .Custom)
        forward.frame = CGRect(x: 64, y: 0, width: 44, height: 44)
     //   forward.setTitle("forward", forState: .Normal)
        forward.setImage(UIImage(named: "forwardarrow"), forState: UIControlState())
        forward.imageView?.clipsToBounds = true
        forward.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        forward.addTarget(self, action: #selector(BookingScreenViewController.forwardButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        bottom.addSubview(forward)
        
        let stop = UIButton(type: .Custom)
        stop.frame = CGRect(x: 128, y: 0, width: 44, height: 44)
     //   stop.setTitle("stop", forState: .Normal)
        stop.setImage(UIImage(named: "stop"), forState: UIControlState())
        stop.imageView?.clipsToBounds = true
        stop.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        stop.addTarget(self, action: #selector(BookingScreenViewController.stopButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        bottom.addSubview(stop)
        
        let reload = UIButton(type: .Custom)
        reload.frame = CGRect(x: 192, y: 0, width: 44, height: 44)
      //  reload.setTitle("stop", forState: .Normal)
        reload.setImage(UIImage(named: "reload"), forState: UIControlState())
        reload.imageView?.clipsToBounds = true
        reload.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        reload.addTarget(self, action: #selector(BookingScreenViewController.reloadButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        bottom.addSubview(reload)
        
        let cancel = UIButton(type: .Custom)
        cancel.frame = CGRect(x: UIScreen.mainScreen().bounds.width-64, y: 0, width: 64, height: 44)
        cancel.setTitleColor(UIColor.grayColor(), forState: UIControlState())
        cancel.setTitle("cancel", forState: UIControlState())
        cancel.addTarget(self, action: #selector(BookingScreenViewController.cancelButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        bottom.addSubview(cancel)
    }
    
    convenience init(string : String) {
        self.init(nibName: nil , bundle:nil, str : string)
    }

     init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle? , str : String) {
        self.string = str
        super.init(nibName: nil, bundle: nil )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func backButtonTapped() {
        webView.goBack()
    }
    
    func forwardButtonTapped() {
        webView.goForward()
    }
  
    func stopButtonTapped() {
        webView.stopLoading()
    }
    
    func reloadButtonTapped() {
        webView.reload()
    }
    
    func cancelButtonTapped() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
