//
//  MovieDetailViewController.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 17/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController , UIScrollViewDelegate {
    
    //MARK: - Properties
    
    var movie : NSDictionary!
    var firstAppear = true
    var scrollView : UIScrollView!
    var navigCRef : UINavigationController?
    var controlRef : SLPagingViewSwift?
    var scrollerGallery : UIScrollView!
    
    var photosurlsArray = NSMutableArray()
    
    var imagesArray = NSMutableArray()
    
    
    init ( selectedMovie : NSDictionary ) {
        
        self.movie = selectedMovie
        super.init(nibName: nil, bundle: nil)
        
        print("got this dictionary from movies list page : \(movie)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - ViewController life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigCRef?.navigationBarHidden = true
        print("movie came from there is \(self.movie)")
        
        var width : CGFloat = self.view.frame.width
        var height : CGFloat = self.view.frame.height
        var xAxis : CGFloat = 0
        var yAxis : CGFloat = 0
        
        
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "loginBackground")?.drawInRect(self.view.bounds)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        self.view.backgroundColor = UIColor.init(patternImage: image)
        
        self.view.backgroundColor = UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0)
        
        // navigationBar
        height = 64
        let navigView : UIView = UIView(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        
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
        btnBack.setImage(UIImage(named: "Arrow_left"), forState: .Normal)
        btnBack.tintColor = UIColor.whiteColor()
        btnBack.addTarget(self, action: #selector(MovieDetailViewController.dismissVC), forControlEvents: .TouchUpInside)
        navigView.addSubview(btnBack)
        navigView.backgroundColor = UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
        view.addSubview(navigView)
        
        width = navigView.frame.size.width-(btnBack.frame.size.width*2+50)
        xAxis = navigView.frame.size.width/2-width/2
        yAxis = btnBack.frame.origin.y
        height = 30
        
        let lblMovieDetails = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        lblMovieDetails.backgroundColor = UIColor.clearColor()
        lblMovieDetails.text = "Movie Details"
        lblMovieDetails.font = UIFont(name: "Helvetica Neue", size: 18)
        lblMovieDetails.textColor = UIColor.whiteColor()
        lblMovieDetails.textAlignment = NSTextAlignment.Center
        navigView.addSubview(lblMovieDetails)
        
        yAxis = navigView.bounds.height
        height = self.view.bounds.height - navigView.bounds.height
        width = self.view.bounds.width
        xAxis = 0
        
        let rect = CGRect(x: xAxis, y: yAxis, width: width,height: height)
        scrollView = UIScrollView(frame:rect)
        scrollView.backgroundColor = UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0)
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: 1050)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
        self.view.addSubview(scrollView)
        
        
        // webview
        xAxis = 0
        yAxis = 0
        width = self.view.bounds.width
        height = 220
        
        
        
        
        let webPlayer = UIWebView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
//        webPlayer.loadRequest(NSURLRequest(URL: NSURL(string:  movie["trailarurl"] as! String)!))
        webPlayer.loadRequest(NSURLRequest(URL: NSURL(string: movie["trailarurl"] as! String)!))
        webPlayer.scrollView.scrollEnabled = false
        scrollView.addSubview(webPlayer)
        
        let viewWebCover = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height/4))
        viewWebCover.backgroundColor = UIColor.clearColor()
        webPlayer.addSubview(viewWebCover)
        
        // btnBooking
        width = 100
        height = 30
        xAxis = self.view.bounds.width/2
        
        
        
        
        
        // booking button
        width = 200
        height = 40
        xAxis = self.view.bounds.width/2 - width/2
        yAxis = webPlayer.frame.origin.y + webPlayer.bounds.size.height + 10
        
        let btnBooking = UIButton(type: .Custom)
        btnBooking.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        btnBooking.layer.cornerRadius = 3.0
        btnBooking.clipsToBounds = true
        let str : NSAttributedString = NSAttributedString(string: "Book", attributes: [
            NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 14.0)!,
            NSForegroundColorAttributeName : UIColor.whiteColor(), NSBackgroundColorAttributeName : UIColor.clearColor()])
        btnBooking.setAttributedTitle(str, forState: UIControlState())
        btnBooking.backgroundColor = UIColor.init(colorLiteralRed: 0, green: 177/255.0, blue: 106/255.0, alpha: 1.0)
        btnBooking.addTarget(self, action: #selector(MovieDetailViewController.presentBookingVC(_:)), forControlEvents: .TouchUpInside)
        btnBooking.titleLabel?.textColor = UIColor.whiteColor()
        scrollView.addSubview(btnBooking)
        
        // title label
        width = self.view.bounds.size.width
        height = 30
        xAxis = 10
        yAxis = btnBooking.frame.origin.y + btnBooking.bounds.size.height + 10
        let lblTitle = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        
        lblTitle.text = movie["mname"] as? String
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.minimumScaleFactor = 0.7
        lblTitle.font = UIFont(name: "Helvetica Neue", size: 18)
        lblTitle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //   lblTitle.shadowColor = UIColor.blackColor()
        //   lblTitle.shadowOffset = CGSize(width: 1, height: 1)
        lblTitle.textColor = UIColor.whiteColor()
        scrollView.addSubview(lblTitle)
        
        
        // details labels 4 in onw row
        width = (self.view.bounds.width-20)
        height = 30
        xAxis = 10
        yAxis = lblTitle.frame.origin.y + lblTitle.bounds.size.height
        
        let lblMovieType = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        lblMovieType.text = (movie["movietype"] as? String)!
        lblMovieType.textAlignment = .Left
        //  lblMovieType.adjustsFontSizeToFitWidth = true
        //  lblMovieType.minimumScaleFactor = 0.7
        lblMovieType.font = UIFont.systemFontOfSize(12)
        //  lblMovieType.autoresize()
        lblMovieType.lineBreakMode = NSLineBreakMode.ByClipping
        lblMovieType.textColor = UIColor.whiteColor()
        scrollView.addSubview(lblMovieType)
        
        yAxis = lblMovieType.frame.origin.y + lblMovieType.bounds.height
        width = width/3
        
        let lblCensor = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        lblCensor.text = (movie["censor"] as? String)!
        lblCensor.textAlignment = .Center
        lblCensor.adjustsFontSizeToFitWidth = true
        lblCensor.minimumScaleFactor = 0.7
        lblCensor.font = UIFont.systemFontOfSize(12)
        lblCensor.lineBreakMode = NSLineBreakMode.ByClipping
        lblCensor.textColor = UIColor.whiteColor()
        scrollView.addSubview(lblCensor)
        
        
        xAxis = lblCensor.frame.origin.x + lblCensor.bounds.size.width
        let lblLength = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        lblLength.text = (movie["length"] as? String)!
        lblLength.textAlignment = .Center
        lblLength.adjustsFontSizeToFitWidth = true
        lblLength.minimumScaleFactor = 0.7
        lblLength.font = UIFont.systemFontOfSize(12)
        lblLength.lineBreakMode = NSLineBreakMode.ByClipping
        lblLength.textColor = UIColor.whiteColor()
        scrollView.addSubview(lblLength)
        
        
        xAxis = lblLength.frame.origin.x + lblLength.bounds.size.width
        let lblReleaseDate = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        
        //        let dateString = movie["releasedate"] as! String
        //        let trimmedDateString = (dateString as NSString).substringToIndex(10)
        //        let dateformatter = NSDateFormatter()
        //        dateformatter.dateFormat = "yy-MM-dd"
        //        let dateInString = dateformatter.dateFromString(trimmedDateString)!
        //        print("date in required format \(dateInString)")
        //        let calendar = NSCalendar.currentCalendar()
        //        let components : NSDateComponents = calendar.components([NSCalendarUnit.Year,NSCalendarUnit.Month,NSCalendarUnit.Day], fromDate: dateInString)
        //        let textString = "\(components.day)-\(components.month)-\(components.year)"
        
        lblReleaseDate.text = "23 JULY 16"
        lblReleaseDate.textAlignment = .Center
        lblReleaseDate.adjustsFontSizeToFitWidth = true
        lblReleaseDate.minimumScaleFactor = 0.7
        lblReleaseDate.font = UIFont.systemFontOfSize(12)
        lblReleaseDate.lineBreakMode = NSLineBreakMode.ByClipping
        lblReleaseDate.textColor = .whiteColor()
        scrollView.addSubview(lblReleaseDate)
        
        
        
        yAxis = lblReleaseDate.frame.origin.y + lblReleaseDate.bounds.size.height + 10
        xAxis = 0
        width = self.view.bounds.width
        height = 1
        
        let seperatorLine = UIView(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        seperatorLine.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(seperatorLine)
        
        // director , producedby labels
        xAxis = 10
        yAxis = seperatorLine.frame.origin.y + seperatorLine.bounds.size.height + 10
        height = 30
        
        let lblDirector = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width-10,height: height))
        lblDirector.text = "Director : \(movie["mdirector"] as! String)"
        lblDirector.textAlignment = .Left
        lblDirector.adjustsFontSizeToFitWidth = true
        lblDirector.minimumScaleFactor = 0.7
        lblDirector.font = UIFont.systemFontOfSize(15)
        lblDirector.lineBreakMode = NSLineBreakMode.ByClipping
        lblDirector.textColor = .whiteColor()
        scrollView.addSubview(lblDirector)
        
        yAxis =  lblDirector.frame.origin.y + lblDirector.bounds.size.height + 5
        
        let lblProducer = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width-10,height: height))
        lblProducer.text = "Producer : \(movie["producer"] as! String)"
        lblProducer.textAlignment = .Left
        lblProducer.numberOfLines = 3
        lblProducer.adjustsFontSizeToFitWidth = true
        lblProducer.minimumScaleFactor = 0.7
        lblProducer.font = UIFont.systemFontOfSize(15)
        lblProducer.lineBreakMode = NSLineBreakMode.ByClipping
        lblProducer.textColor = .whiteColor()
        scrollView.addSubview(lblProducer)
        
        yAxis =  lblProducer.frame.origin.y + lblProducer.bounds.size.height + 5
        
        let lblCast = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width-10,height: 60))
        lblCast.text = "Cast : \(movie["actors"] as! String)"
        lblCast.textAlignment = .Left
        lblCast.numberOfLines = 3
        lblCast.adjustsFontSizeToFitWidth = true
        lblCast.minimumScaleFactor = 0.7
        lblCast.font = UIFont.systemFontOfSize(15)
        lblCast.lineBreakMode = NSLineBreakMode.ByClipping
        lblCast.textColor = .whiteColor()
        scrollView.addSubview(lblCast)
        
        
        yAxis =  lblCast.frame.origin.y + lblCast.bounds.size.height + 5
        
        let btnLink = UIButton(type: .Custom)
        btnLink.frame = CGRect(x: xAxis, y: yAxis, width: width-20, height: height)
        let linkString = "See full cast and crew >>"
        btnLink.setTitle(linkString, forState: UIControlState())
        btnLink.backgroundColor = UIColor.clearColor()
        btnLink.titleLabel?.textColor = UIColor.whiteColor()
        btnLink.addTarget(self, action: #selector(MovieDetailViewController.showFullCastInfo), forControlEvents: .TouchUpInside)
        scrollView.addSubview(btnLink)
        
        yAxis =  btnLink.frame.origin.y + btnLink.bounds.size.height + 10
        
        let seperatorLine1 = UIView(frame: CGRect(x: 0, y: yAxis, width: width, height: 1))
        seperatorLine1.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(seperatorLine1)
        
        yAxis =  seperatorLine1.frame.origin.y + seperatorLine1.bounds.size.height + 10
        
        let lblDescription = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width-20,height: 120))
        let storyLineText = movie["storyline"] as! String
        let maximumLabelSize = CGSize(width: 296,height: 9999);
        
        
        
        let expectedLabelSize = (storyLineText as NSString).sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(15)])
        //        var newlabelFrame : CGRect = lblDescription.frame
        //        newlabelFrame.size.height = expectedLabelSize.height
        //  lblDescription.frame = newlabelFrame
        lblDescription.text = (movie["storyline"] as! String)
        lblDescription.textAlignment = .Left
        lblDescription.numberOfLines = 10
        lblDescription.adjustsFontSizeToFitWidth = true
        //  lblDescription.minimumScaleFactor = 0.7
        lblDescription.font = UIFont.systemFontOfSize(15)
        lblDescription.lineBreakMode = NSLineBreakMode.ByClipping
        lblDescription.textColor = .whiteColor()
        lblDescription.autoresize()
        scrollView.addSubview(lblDescription)
        
        yAxis =  lblDescription.frame.origin.y + lblDescription.bounds.size.height + 10
        
        let seperatorLine2 = UIView(frame: CGRect(x: 0, y: yAxis, width: width, height: 1))
        seperatorLine2.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(seperatorLine2)
        
        
        yAxis =  seperatorLine2.frame.origin.y + seperatorLine2.bounds.size.height + 10
        xAxis = 10
        width = (self.view.bounds.width-20)/4
        height = 30
        
        let lblBookMyShowVal = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        lblBookMyShowVal.text = "4/5"
        lblBookMyShowVal.textAlignment = .Center
        lblBookMyShowVal.adjustsFontSizeToFitWidth = true
        lblBookMyShowVal.minimumScaleFactor = 0.7
        lblBookMyShowVal.font = UIFont.systemFontOfSize(15)
        lblBookMyShowVal.lineBreakMode = NSLineBreakMode.ByClipping
        lblBookMyShowVal.textColor = .whiteColor()
        scrollView.addSubview(lblBookMyShowVal)
        
        let IMDBval = UILabel(frame: CGRect(x: lblBookMyShowVal.frame.origin.x + lblBookMyShowVal.bounds.width,y: yAxis,width: width,height: height))
        IMDBval.text = "3/5"
        IMDBval.textAlignment = .Center
        IMDBval.adjustsFontSizeToFitWidth = true
        IMDBval.minimumScaleFactor = 0.7
        IMDBval.font = UIFont.systemFontOfSize(15)
        IMDBval.lineBreakMode = NSLineBreakMode.ByClipping
        IMDBval.textColor = .whiteColor()
        scrollView.addSubview(IMDBval)
        
        let GreatAndhraVal = UILabel(frame: CGRect(x: IMDBval.frame.origin.x + width,y: yAxis,width: width ,height: height))
        GreatAndhraVal.text = "4.5/5"
        GreatAndhraVal.textAlignment = .Center
        GreatAndhraVal.adjustsFontSizeToFitWidth = true
        GreatAndhraVal.minimumScaleFactor = 0.7
        GreatAndhraVal.font = UIFont.systemFontOfSize(15)
        GreatAndhraVal.lineBreakMode = NSLineBreakMode.ByClipping
        GreatAndhraVal.textColor = .whiteColor()
        scrollView.addSubview(GreatAndhraVal)
        
        let _123TeluguVal = UILabel(frame: CGRect(x: GreatAndhraVal.frame.origin.x + GreatAndhraVal.bounds.width,y: yAxis,width: width,height: height))
        _123TeluguVal.text = "4.5/5"
        _123TeluguVal.textAlignment = .Center
        _123TeluguVal.adjustsFontSizeToFitWidth = true
        _123TeluguVal.minimumScaleFactor = 0.7
        _123TeluguVal.font = UIFont.systemFontOfSize(15)
        _123TeluguVal.lineBreakMode = NSLineBreakMode.ByClipping
        _123TeluguVal.textColor = .whiteColor()
        scrollView.addSubview(_123TeluguVal)
        
        yAxis = lblBookMyShowVal.frame.origin.y + height
        
        
        let lblBookMyShow = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        lblBookMyShow.text = "BookMyShow"
        lblBookMyShow.textAlignment = .Center
        lblBookMyShow.adjustsFontSizeToFitWidth = true
        lblBookMyShow.minimumScaleFactor = 0.7
        lblBookMyShow.font = UIFont.systemFontOfSize(12)
        lblBookMyShow.lineBreakMode = NSLineBreakMode.ByClipping
        lblBookMyShow.textColor = .whiteColor()
        scrollView.addSubview(lblBookMyShow)
        
        let IMDB = UILabel(frame: CGRect(x: lblBookMyShow.frame.origin.x + width,y: yAxis,width: width,height: height))
        IMDB.text = "IMDB"
        IMDB.textAlignment = .Center
        IMDB.adjustsFontSizeToFitWidth = true
        IMDB.minimumScaleFactor = 0.7
        IMDB.font = UIFont.systemFontOfSize(12)
        IMDB.lineBreakMode = NSLineBreakMode.ByClipping
        IMDB.textColor = .whiteColor()
        scrollView.addSubview(IMDB)
        
        let GreatAndhra = UILabel(frame: CGRect(x: IMDB.frame.origin.x + width,y: yAxis,width: width,height: height))
        GreatAndhra.text = "GreatAndhra"
        GreatAndhra.textAlignment = .Center
        GreatAndhra.adjustsFontSizeToFitWidth = true
        GreatAndhra.minimumScaleFactor = 0.7
        GreatAndhra.font = UIFont.systemFontOfSize(12)
        GreatAndhra.lineBreakMode = NSLineBreakMode.ByClipping
        GreatAndhra.textColor = .whiteColor()
        scrollView.addSubview(GreatAndhra)
        
        let _123Telugu = UILabel(frame: CGRect(x: GreatAndhra.frame.origin.x + GreatAndhra.bounds.width,y: yAxis,width: width,height: height))
        _123Telugu.text = "123Telugu"
        _123Telugu.textAlignment = .Center
        _123Telugu.adjustsFontSizeToFitWidth = true
        _123Telugu.minimumScaleFactor = 0.7
        _123Telugu.font = UIFont.systemFontOfSize(12)
        _123Telugu.lineBreakMode = NSLineBreakMode.ByClipping
        _123Telugu.textColor = .whiteColor()
        scrollView.addSubview(_123Telugu)
        
        yAxis =  _123Telugu.frame.origin.y + _123Telugu.bounds.size.height + 10
        width = self.view.bounds.width
        
        let seperatorLine3 = UIView(frame: CGRect(x: 0, y: yAxis, width: width, height: 1))
        seperatorLine3.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(seperatorLine3)
        
        yAxis =  seperatorLine3.frame.origin.y + seperatorLine3.bounds.size.height + 10
        xAxis = self.view.bounds.width/2 - 125
        let galleryBtn = UIButton(type: .Custom)
        galleryBtn.frame = CGRect(x: xAxis, y: yAxis, width: 250, height: height)
        galleryBtn.setTitle( "Gallery and Videos", forState: UIControlState())
        galleryBtn.backgroundColor = UIColor.clearColor()
        galleryBtn.titleLabel?.textColor = UIColor.whiteColor()
        galleryBtn.addTarget(self, action: #selector(MovieDetailViewController.presentGallery), forControlEvents: .TouchUpInside)
        scrollView.addSubview(galleryBtn)
        
        
        xAxis = 10
        yAxis =  galleryBtn.frame.origin.y + galleryBtn.bounds.size.height + 10
        //   height = scrollView.contentSize.height - yAxis - 10
        height = 120
        
        scrollerGallery = UIScrollView(frame: CGRect(x: xAxis,y: yAxis,width: width-20,height: height))
        scrollerGallery.backgroundColor = UIColor.clearColor()
        
        let totalPics = (movie["movieImagesList"]! as AnyObject).count
        
        let xOffSet : CGFloat = 120 * CGFloat(totalPics!) + CGFloat(totalPics!-1)
        
        //        for(var index : CGFloat = 0 ; index < 1 ; index = index + 1) {
        //            let imageWidth : CGFloat = 80
        //            let imgVw = UIImageView(frame: CGRectMake(xOffSet + 1, yAxis, imageWidth, height))
        //            let img = UIImage(named: "defaultthumbnail.png")
        //            imgVw.image = img
        //            scrollerGallery.addSubview(imgVw)
        //            xOffSet += imageWidth
        //        }
        
        scrollerGallery.contentSize = CGSize(width: xOffSet, height: height)
        scrollView.addSubview(scrollerGallery)
        yAxis = scrollerGallery.frame.origin.y + scrollerGallery.bounds.height
        print("yaxis is \(yAxis)")
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: yAxis + 10 )
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //All stuff here
            self.loadImagesIntoImagesArray()
        })
        
        
        
    }
    
    //MARK: - Button Events
    func dismissVC () {
        navigCRef?.navigationBar.hidden = false
        navigCRef?.navigationBarHidden = false
        navigCRef!.popToViewController(controlRef!, animated: true)
    }
    
    func showFullCastInfo() {
        print("btn event")
        
        
    }
    
    func presentBookingVC (sender : UIButton) {
        
        if photosurlsArray.count != 0{
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            if let bookingVC = storyBoard.instantiateViewControllerWithIdentifier("BookingViewController") as? BookingViewController {
                bookingVC.navigRef = self.navigCRef
                bookingVC.movie = self.movie
                bookingVC.photoURlsArray = self.photosurlsArray
                bookingVC.movieTitle = movie["mname"] as! String
                
                
                
                navigCRef?.pushViewController(bookingVC, animated: true)
                
            }
        }
        else{
            let alertView_ = UIAlertView(title: "City Movies", message: "No bookings found for this movie.", delegate: nil, cancelButtonTitle: "Ok")
            alertView_.show()
        }
    }
    
    func  presentGallery () -> () {
        
        let gallery = GalleryViewController()
        gallery.navigRef = navigCRef
        gallery.PhotoURlsArray = photosurlsArray
        gallery.movie = self.movie
        navigCRef?.pushViewController(gallery, animated: true)
        
    }
    
    func loadImagesIntoImagesArray() {
        
        var localArray = NSArray()
        localArray = movie.valueForKey( "movieImagesList") as! NSArray
        var xAxis :CGFloat = 0
        for (index,obj) in localArray.enumerate() {
            let dict = obj as! NSDictionary
            let sstr : NSString = NSString(format: "http://img.youtube.com/vi/%@/hqdefault.jpg",dict["IMG_Code"] as! String)
            photosurlsArray.addObject(sstr)
            //   self.imagesArray.arrayByAddingObject(sstr)
            
//            let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: URL!) -> Void in
//                print(self)
//            }
            
            let rect : CGRect = CGRect(x: xAxis,y: 0,width: 120,height: self.scrollerGallery.bounds.height)
            let imageView = UIImageView(frame: rect)
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.clipsToBounds = true
            
            let imgPlaceholder = UIImage(named: "Placeholder_male")
            //ImagedNeeded
            imageView.kf_setImageWithURL(NSURL(string: sstr as String)!, placeholderImage: imgPlaceholder, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            
            self.scrollerGallery.addSubview(imageView)
            self.scrollerGallery.showsHorizontalScrollIndicator = false
            self.scrollerGallery.showsVerticalScrollIndicator = false
            xAxis = xAxis + 120 + 1
            
            
            let galleryBtnBig = UIButton(type: .Custom)
            galleryBtnBig.frame = imageView.bounds
            galleryBtnBig.backgroundColor = UIColor.clearColor()
            galleryBtnBig.addTarget(self, action: #selector(MovieDetailViewController.presentGallery), forControlEvents: .TouchUpInside)
            self.scrollerGallery.addSubview(galleryBtnBig)
            
        }
        //  setImagesToScrollGallery()
        self.view.layoutIfNeeded()
    }
}
