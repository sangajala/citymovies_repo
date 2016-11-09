//
//  GalleryViewController.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 08/06/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Kingfisher

class GalleryViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource , UIScrollViewDelegate{
    
    var navigRef : UINavigationController?
    var controlRef : SLPagingViewSwift?
    var segmentedControl =  HMSegmentedControl()
    var videosCollectionView : UICollectionView!
    var photosCollectionView : UICollectionView!
    var movie = NSDictionary()
    var PhotoURlsArray = NSMutableArray() // this is from movies detail view controlller
    var photosurlsArray = NSMutableArray()
    var videosurlsArray = NSMutableArray()
    
    var cache = NSMutableDictionary()
    
    var ZoomableView = UIScrollView()
    var imageView = UIImageView()
    
    //MARK: -View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //   print("adsafdsgdsgdhdsgdsg \(PhotoURlsArray)")
        navigRef?.navigationBarHidden = true
        
        
        navigRef?.navigationItem.backBarButtonItem = nil
        navigRef?.navigationItem.hidesBackButton = true
        var item = navigRef?.navigationBar.backItem
        item = nil
        
        navigRef?.navigationBarHidden = true
        navigRef?.navigationItem.hidesBackButton = true
        navigRef?.navigationItem.hidesBackButton = true
        navigRef?.navigationBar.barTintColor = UIColor.blackColor()
        //        videosCollectionView = UICollectionView()
        //        photosCollectionView = UICollectionView()
        
        var xAxis : CGFloat = 0
        var yAxis : CGFloat = 0
        var width : CGFloat = self.view.bounds.width
        var height : CGFloat = self.view.bounds.height
        
        let reqColor = UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue:72/255.0, alpha: 0.9)
        
        self.view.backgroundColor = reqColor
        
        //        let backgroundImageView = UIImageView(frame: CGRectMake(xAxis, yAxis, width, height))
        //        backgroundImageView.image = UIImage(named: "sidemenubg")
        //        view.addSubview(backgroundImageView)
        
        height = 64
        
        let headerView : UIView = UIView(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        headerView.backgroundColor = UIColor.clearColor()
        
        
//        yAxis = headerView.frame.size.height/2
//        let backButton = UIButton(type: .Custom)
//        backButton.frame = CGRectMake(xAxis, yAxis, 30, 30)
//        backButton.setImage(UIImage(named: "Arrow_left"), forState: .Normal)
//        backButton.userInteractionEnabled = true
//        backButton.backgroundColor = UIColor.clearColor()Color()
//        backButton.addTarget(self, action: #selector(SettingsViewController.dismissVC), forControlEvents: UIControlEvents.TouchUpInside)
//        headerView.addSubview(backButton)
//        
//        xAxis = headerView.frame.midX - 40
//        yAxis = headerView.frame.midY
//        let titleLabel = UILabel(frame: CGRectMake(xAxis,yAxis,80,30))
//        titleLabel.backgroundColor = UIColor.clearColor()Color()
//        titleLabel.text = "Gallery"
//        titleLabel.textColor = UIColor.whiteColor()
//        headerView.addSubview(titleLabel)
        
        height = 30
        width = 30
        xAxis = 10
        yAxis = 20 + ((headerView.frame.size.height-20)/2-height/2)
        
        let btnBack = UIButton(type: .Custom)
        btnBack.frame = CGRect(x: xAxis,y: yAxis,width: width,height: height)
        btnBack.userInteractionEnabled = true
        btnBack.setImage(UIImage(named: "Arrow_left"), forState: UIControlState())
        btnBack.tintColor = UIColor.whiteColor()
        btnBack.addTarget(self, action: #selector(SettingsViewController.dismissVC), forControlEvents: .TouchUpInside)
        headerView.addSubview(btnBack)
        headerView.backgroundColor = UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
        view.addSubview(headerView)
        
        width = headerView.frame.size.width-(btnBack.frame.size.width*2+50)
        xAxis = headerView.frame.size.width/2-width/2
        yAxis = btnBack.frame.origin.y
        height = 30
        
        let lblMovieDetails = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        lblMovieDetails.backgroundColor = UIColor.clearColor()
        lblMovieDetails.text = "Gallery"
        lblMovieDetails.font = UIFont(name: "Helvetica Neue", size: 18)
        lblMovieDetails.textColor = UIColor.whiteColor()
        lblMovieDetails.textAlignment = NSTextAlignment.Center
        headerView.addSubview(lblMovieDetails)
        
        view.addSubview(headerView)
        
        yAxis = headerView.bounds.height
        height = 44
        xAxis = 0
        width = self.view.bounds.width
        //  segmentedControl = HMSegmentedControl(sectionTitles: ["VIDEOS","PHOTOS"])
        segmentedControl.sectionTitles = [ "VIDEOS", "PHOTOS"]
        segmentedControl.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        let attributes = [
            NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 14.0)!,
            NSForegroundColorAttributeName : UIColor.whiteColor(), NSBackgroundColorAttributeName : UIColor.clearColor()]
        segmentedControl.selectedTitleTextAttributes = attributes
        segmentedControl.titleTextAttributes = attributes
        segmentedControl.tintColor = UIColor.whiteColor()
        segmentedControl.backgroundColor = UIColor.clearColor()
        segmentedControl.selectionIndicatorColor = UIColor.init(colorLiteralRed: 255/255.0, green: 65/255.0, blue: 131/255.0, alpha: 1.0)//255 65 131
        segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        segmentedControl.selectionIndicatorHeight = 2;
        self.view.addSubview(segmentedControl)
        self.displayVideos()
        loadURLsIntoImagesURLsArray()
        loadURLsIntoVideosURLsArray()
        
        segmentedControl.indexChangeBlock = { (index) in
            if index == 0{
                self.displayVideos()
                
            } else if index == 1 {
                self.displayPhotos()
            }
            
        }
        
        
    }
    
    func displayVideos() {
        if self.photosCollectionView != nil {
            self.photosCollectionView.removeFromSuperview()
        }
        print("Show videos")
        
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        layout.itemSize = CGSize(width: self.view.bounds.width , height: 220)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        self.videosCollectionView = UICollectionView(frame: CGRect(x: 0,y: 108,width: self.view.bounds.width
            ,height: self.view.bounds.height-108), collectionViewLayout: layout)
        self.videosCollectionView.tag = 0
        self.videosCollectionView.showsVerticalScrollIndicator = false
        self.videosCollectionView.showsHorizontalScrollIndicator = false
        self.videosCollectionView.backgroundColor = UIColor.clearColor()
        self.videosCollectionView.delegate = self
        self.videosCollectionView.dataSource = self
        self.videosCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(self.videosCollectionView)
    }
    
    func displayPhotos() {
        print("show photos")
        if self.videosCollectionView != nil {
            self.videosCollectionView.removeFromSuperview()
        }
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.itemSize = CGSize(width: (self.view.bounds.width-2)/2 - 1.5 , height: 120)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        self.photosCollectionView = UICollectionView(frame: CGRect(x: 0,y: 128,width: self.view.bounds.width-2
            ,height: self.view.bounds.height-128), collectionViewLayout: layout)
        self.photosCollectionView.tag = 1
        self.photosCollectionView.showsVerticalScrollIndicator = false
        self.photosCollectionView.showsHorizontalScrollIndicator = false
        self.photosCollectionView.backgroundColor = UIColor.clearColor()
        self.photosCollectionView.delegate = self
        self.photosCollectionView.dataSource = self
        self.photosCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(self.photosCollectionView)
    }
    
    //MARK:- collection view methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if collectionView.tag == 0 {
            return videosurlsArray.count
        }
        else if collectionView.tag == 1 {
            return photosurlsArray.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            
            var cell: UICollectionViewCell! = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
            
            //            if cell == nil{
            //                let layoutAttributes : UICollectionViewLayoutAttributes = collectionView.layoutAttributesForItemAtIndexPath(indexPath)!
            //                cell = VideoCollectionViewCell.init(frame: layoutAttributes.frame, reuseIdentifier: "Cell", videoURL: videosurlsArray[indexPath.row] as! String)
            //
            //              //  cell.webView = UIWebView(frame: layoutAttributes.frame)
            //                let url = NSURL(string: videosurlsArray[indexPath.row] as! String)
            //                let request = NSURLRequest(URL: url!)
            //                cell.webView.loadRequest(request)
            //                cell.webView.scrollView.scrollEnabled = false
            //                cell.webView.reload()
            //
            //              //  cell.contentView.addSubview(cell.webView)
            //            }
            
            if cache.objectForKey("key\((indexPath as NSIndexPath).row)" ) != nil{
                cell = cache.objectForKey("key\((indexPath as NSIndexPath).row)") as? UICollectionViewCell
            }
            else{
                cell.backgroundColor = UIColor.clearColor()
                let layoutAttributes : UICollectionViewLayoutAttributes = collectionView.layoutAttributesForItemAtIndexPath(indexPath)!
                
                let viewWebCover = UIView(frame: CGRect(x: 0, y: 0, width: layoutAttributes.frame.size.width, height: layoutAttributes.frame.size.height/4))
                viewWebCover.backgroundColor = UIColor.clearColor()
                
                let web = UIWebView(frame:CGRect(x: 0,y: 0,width: layoutAttributes.frame.size.width,height: layoutAttributes.frame.size.height))
                let url = NSURL(string: videosurlsArray[(indexPath as NSIndexPath).row] as! String)
                let request = NSURLRequest(URL: url!)
                web.loadRequest(request)
                web.scrollView.scrollEnabled = false
                
                web.addSubview(viewWebCover)
                cell.contentView.addSubview(web)
                cache.setObject(cell, forKey: "key\((indexPath as NSIndexPath).row)" as NSCopying)
            }
            
            return cell
            
        }else if collectionView.tag == 1 {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier( "Cell", forIndexPath: indexPath)
            let layoutAttributes : UICollectionViewLayoutAttributes = collectionView.layoutAttributesForItemAtIndexPath(indexPath)!
            let photoView = UIImageView(frame: CGRect(x: 0,y: 0,width: layoutAttributes.frame.size.width,height: layoutAttributes.frame.size.height))
            photoView.contentMode = UIViewContentMode.ScaleAspectFill
            photoView.clipsToBounds = true
            cell.contentView.addSubview(photoView)
//            let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: URL!) -> Void in
//                print(self)
//            }
            
            let imgPlaceholder = UIImage(named: "placeholder_movie")
            
            //ImagedNeeded
            photoView.kf_setImageWithURL(NSURL(string: photosurlsArray[(indexPath as NSIndexPath).row] as! String)!, placeholderImage: imgPlaceholder, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            
//            photoView.sd_setImage(with: NSURL(string: photosurlsArray[(indexPath as NSIndexPath).row] as! String), completed: block)
            
            cell.backgroundColor = UIColor.clearColor()
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAt indexPath: NSIndexPath) {
        
        
        self.ZoomableView.removeFromSuperview()
        if collectionView.tag == 1 {
            
            
            
            
            //            let ZoomableView = UIScrollView(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height))
            //            ZoomableView.userInteractionEnabled = true
            //            ZoomableView.minimumZoomScale = 1.0
            //            ZoomableView.maximumZoomScale = 2.0
            //             imageView = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height))
            //            imageView.userInteractionEnabled = true
            //            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            //            ZoomableView.addSubview(imageView)
            //            let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
            //                print(self)
            //            }
            // imageView.sd_setImageWithURL(NSURL(string: photosurlsArray[indexPath.row] as! String), completed: block)
            //            ZoomableView.delegate = self
            //            ZoomableView.tag = 10
            //            ZoomableView.Center = self.view.Center
            //
            //            self.view.addSubview(ZoomableView)
            //
            //            let headerView = UIView(frame: CGRectMake(0,0,self.view.bounds.width,58))
            //            headerView.backgroundColor = UIColor.clearColor()Color()
            //            headerView.tag = 11
            //            let errorButton = UIButton(type: .Custom)
            //            errorButton.setImage(UIImage(named: "error.png"), forState: .Normal)
            //            errorButton.frame = CGRectMake(self.view.bounds.width - 50, 8, 50, 50)
            //            errorButton.addTarget(self, action: #selector(GalleryViewController.removeTheZoomView), forControlEvents: .TouchUpInside)
            //            headerView.addSubview(errorButton)
            //            self.view.addSubview(headerView)
            
            
            let storyBd = UIStoryboard(name: "Main", bundle: nil)
            let zoomVC = storyBd.instantiateViewControllerWithIdentifier("ZoomableViewController") as! ZoomableViewController
            zoomVC.str = photosurlsArray[(indexPath as NSIndexPath).row] as? String
            presentViewController(zoomVC, animated: true, completion: nil)
        }
    }
    
    func removeTheZoomView() -> () {
        print("button tapped")
        let k  = self.view .viewWithTag(10)
        k?.hidden = true
        self.view.bringSubviewToFront(k!)
        k?.removeFromSuperview()
        
        let l  = self.view .viewWithTag(11)
        l?.hidden = true
        self.view.bringSubviewToFront(l!)
        l?.removeFromSuperview()
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touches began \(ZoomableView)")
        ZoomableView.removeFromSuperview()
        
    }
    
    //MARK:- Dismiss VC
    func dismissVC() {
        navigRef?.popViewControllerAnimated(true)
    }
    
    //MARK:- Data Fetching Methods
    
    
    func loadURLsIntoImagesURLsArray() {
        
        var localArray = NSArray()
        localArray = movie.valueForKey( "movieImagesList") as! NSArray
        for (_,obj) in localArray.enumerate() {
            let dict = obj as! NSDictionary
            let sstr : NSString = NSString(format: "http://img.youtube.com/vi/%@/0.jpg",dict["IMG_Code"] as! String)
            photosurlsArray.addObject(sstr)
            
        }
    }
    
    
    func loadURLsIntoVideosURLsArray() {
        
        var localArray = NSArray()
        localArray = movie.valueForKey( "movieVideosList") as! NSArray
        for (_,obj) in localArray.enumerate() {
            let dict = obj as! NSDictionary
            let str : String = dict.valueForKey( "URL") as! String
            videosurlsArray.addObject(str)
            //            if let sstr = NSURL(string: str) {
            //                videosurlsArray.addObject(sstr)
            //                print("qwqwqwqwqwq \(videosurlsArray)")
            //            }
        }
        print("videos urls in array \(self.videosurlsArray)")
        self.videosCollectionView.reloadData()
    }
    
    
    
    
    
}






















