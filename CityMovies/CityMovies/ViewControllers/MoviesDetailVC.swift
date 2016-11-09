//
//  MoviesDetailVC.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 01/09/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit

class MoviesDetailVC: UIViewController, UIScrollViewDelegate {

    //MARK: - Properties
    var movie : NSDictionary!
    var firstAppear = true
    var scrollView : UIScrollView!
    var navigCRef : UINavigationController?
    var controlRef : SLPagingViewSwift?
    var scrollerGallery : UIScrollView!
    var webPlayer = UIWebView()
    var viewForCircles = UIView()
    var viewForSynopsis = UIView()
    
    
    var photosurlsArray = NSMutableArray()
    
    var imagesArray = NSMutableArray()
    
    
    var castTitle = UILabel()
    
    //Movies Details
    var movieYear = UILabel()
    var movieTitle = UILabel()
    
    //Segment related
    //Trailers
    var buttonTraileres = UIButton()
    var imageIcon_trailers = UIImageView()
    var lblTrailersText = UILabel()
    var viewTrailers = UIView()
    
    
    //PhotoGallery
    var buttonPhotoGralley = UIButton()
    var imageIcon_PhotoGallery = UIImageView()
    var lblPhotoGralleyText = UILabel()
    var viewPhotoGralley = UIView()
    
    //Cating
    var buttonCasting = UIButton()
    var imageIcon_casting = UIImageView()
    var lblCastingText = UILabel()
    var viewCasting = UIView()
    
    
    
    
    //MARK: - Initialization Methods
    init ( selectedMovie : NSDictionary ) {
        
        self.movie = selectedMovie
        super.init(nibName: nil, bundle: nil)
        
        print("got this dictionary from movies list page : \(movie)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - ViewController life cycle methods
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        navigCRef?.navigationBarHidden = true
        print("movie came from there is \(self.movie)")
        
        self.view.backgroundColor = UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0)
        
        designOverLay()
        loadImagesIntoImagesArray()
    }
    
    
    //MARK: - Design WebViews
    func designOverLay() {
        
        var height: CGFloat = self.view.bounds.height
        var width: CGFloat = self.view.bounds.width
        var xAxis: CGFloat = 0
        var yAxis: CGFloat = 0
        
        let rect = CGRect(x: xAxis, y: yAxis, width: width,height: height)
        scrollView = UIScrollView(frame:rect)
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: 1050)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = true
        self.view.addSubview(scrollView)
        
        // webview
        height = 220
        width = self.view.frame.width
        xAxis = 0
        yAxis = 64
        
        
        let aryMovieVideos = movie.valueForKey( "MovieVideos") as? NSArray
        let dictMovieVideos = aryMovieVideos![0] as? NSDictionary
        let str_trailarurl = dictMovieVideos!.valueForKey( "URL") as? String
        
        webPlayer = UIWebView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        
        if let urlString = str_trailarurl{
            webPlayer.loadRequest(NSURLRequest(URL: NSURL(string: urlString)!))//Might crash here
        }
        webPlayer.scrollView.scrollEnabled = false
        scrollView.addSubview(webPlayer)
        
        let viewWebCover = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height/4))
        viewWebCover.backgroundColor = UIColor.clearColor()
        webPlayer.addSubview(viewWebCover)
        
        
        height = 64
        width = self.view.frame.width
        xAxis = 0
        yAxis = 0
        
        let viewOverlay = UIView(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
//        viewOverlay.backgroundColor = UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 0.5)
        self.view.addSubview(viewOverlay)
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 1.0).CGColor, UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 0.0).CGColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: viewOverlay.frame.size.width, height: 64)
        viewOverlay.layer.insertSublayer(gradient, atIndex: 0)
        
        
        height = 29
        width = 32
        xAxis = 10
        yAxis = 20 + (44/2-29/2)
        
        let btnBack = UIButton(type: .Custom)
        btnBack.frame = CGRect(x: xAxis,y: yAxis,width: width,height: height)
        btnBack.userInteractionEnabled = true
        btnBack.setImage(UIImage(named: "Arrow_left"), forState: UIControlState())
        btnBack.tintColor = UIColor.whiteColor()
        btnBack.addTarget(self, action: #selector(MoviesDetailVC.dismissVC), forControlEvents: .TouchUpInside)
        viewOverlay.addSubview(btnBack)

        
        designMovieDetails()
    }
    
    func designMovieDetails()  {
        
        print("Desinging movie details")
        
        var height: CGFloat = 15
        var width: CGFloat = 40
        var xAxis: CGFloat = 20
        var yAxis: CGFloat = webPlayer.frame.height+webPlayer.frame.origin.y+30
        
        let movie = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        movie.text = "MOVIE"//237 26 81
        movie.textColor = UIColor.init(red: 237/255.0, green: 26/255.0, blue: 81/255.0, alpha: 1.0)
        movie.textAlignment = .Left
        movie.font = UIFont.systemFontOfSize(12.0)
        movie.backgroundColor = UIColor.clearColor()
        scrollView.addSubview(movie)
        
        height = 15
        width = 30
        xAxis = movie.frame.width+movie.frame.origin.x+5
        yAxis = webPlayer.frame.height+webPlayer.frame.origin.y+30
        
        let str_movieYear = self.movie.valueForKey( "Release_Date") as! String
        
        let range = str_movieYear.endIndex.advancedBy(-4)..<str_movieYear.endIndex
        let subtring = str_movieYear[range]
        
        movieYear = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        movieYear.text = subtring//"2015"//237 26 81
        movieYear.textColor = UIColor.whiteColor()
        movieYear.textAlignment = .Left
        movieYear.font = UIFont.systemFontOfSize(12.0)
        movieYear.backgroundColor = UIColor.clearColor()
        scrollView.addSubview(movieYear)
        
        
        height = 60
        width = scrollView.frame.width-scrollView.frame.width/3
        xAxis = 20
        yAxis = movieYear.frame.height+movieYear.frame.origin.y
        
        movieTitle = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        movieTitle.text = self.movie["Mov_Name"] as? String
        movieTitle.textColor = UIColor.whiteColor()
        movieTitle.textAlignment = .Left
        movieTitle.font = UIFont.systemFontOfSize(23.0)
        movieTitle.backgroundColor = UIColor.clearColor()
        movieTitle.numberOfLines = 5;
        movieTitle.autoresize()
        scrollView.addSubview(movieTitle)
        
        width = scrollView.frame.width/3-(movieTitle.frame.origin.x+15)
        height = width/2
        xAxis = scrollView.frame.width-(width+12)
        yAxis = movieTitle.frame.height+movieTitle.frame.origin.y-height
        
        let btnBook = UIButton(type: .Custom)
        btnBook.frame = CGRect(x: xAxis,y: yAxis,width: width,height: height)
        btnBook.setTitle("BOOK", forState: UIControlState())
        btnBook.backgroundColor = UIColor.clearColor()
        btnBook.setTitleColor(UIColor.init(red: 237/255.0, green: 26/255.0, blue: 81/255.0, alpha: 1.0), forState: UIControlState())
        btnBook.layer.borderWidth = 1.0
        btnBook.layer.borderColor = UIColor.init(red: 237/255.0, green: 26/255.0, blue: 81/255.0, alpha: 1.0).CGColor
        btnBook.titleLabel?.font = UIFont.boldSystemFontOfSize( 20.0)
        btnBook.addTarget(self, action: #selector(MoviesDetailVC.presentBookingVC(_:)), forControlEvents: .TouchUpInside)
        scrollView.addSubview(btnBook)
        
        
        //Casting related title
        width = scrollView.frame.width/2.4
        height = 15
        xAxis = 20
        yAxis = movieTitle.frame.height+movieTitle.frame.origin.y+10
        
        castTitle = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        castTitle.text = self.movie["Movie_Type_Details"] as? String//
        castTitle.textColor = UIColor.whiteColor()
        castTitle.textAlignment = .Left
        castTitle.font = UIFont.systemFontOfSize(12.0)
        castTitle.backgroundColor = UIColor.clearColor()
        castTitle.numberOfLines = 5;
        castTitle.autoresize()
        scrollView.addSubview(castTitle)
        
        
        width = ((scrollView.frame.width/2)/2)+10
        height = 15
        xAxis = castTitle.frame.width+castTitle.frame.origin.x
        yAxis = movieTitle.frame.height+movieTitle.frame.origin.y+10
        
        let durationDetails = "\(self.movie["Duration"] as! String)"
        
        let timeTitle = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        timeTitle.text = durationDetails//"33h 33m - "
        timeTitle.textColor = UIColor.whiteColor()
        timeTitle.textAlignment = .Left
        timeTitle.font = UIFont.systemFontOfSize(12.0)
        timeTitle.backgroundColor = UIColor.clearColor()
        timeTitle.numberOfLines = 5;
        scrollView.addSubview(timeTitle)
        
        width = (scrollView.frame.width/2)/2.1
        height = 15
        xAxis = btnBook.frame.width+btnBook.frame.origin.x-width
        yAxis = movieTitle.frame.height+movieTitle.frame.origin.y+10
        
        let dateDetails = "\(self.movie["Release_Date"] as! String)"
        
        let dateTitle = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        dateTitle.text = dateDetails//"14 Sep 2015"
        dateTitle.textColor = UIColor.whiteColor()
        dateTitle.textAlignment = .Right
        dateTitle.font = UIFont.systemFontOfSize(12.0)
        dateTitle.backgroundColor = UIColor.clearColor()
        dateTitle.numberOfLines = 5;
        scrollView.addSubview(dateTitle)
        

        designViewForCircles()
    }
    
    func designViewForCircles()  {
        
        print("Designing view for circles.")
        
        var xAixs:CGFloat = 20
        var yAixs:CGFloat = castTitle.frame.size.height+castTitle.frame.origin.y+20
        var width:CGFloat = scrollView.frame.size.width-40
        var height:CGFloat = 95
        
        viewForCircles = UIView(frame: CGRect(x: xAixs, y: yAixs, width: width, height: height))
        viewForCircles.backgroundColor = UIColor.clearColor()
        scrollView.addSubview(viewForCircles)
        
    
        xAixs = 0
        yAixs = 0
        width = viewForCircles.frame.size.width/4.5
        var heightForCircle:CGFloat = width
        
        let viewOne = UIView(frame: CGRect(x: xAixs, y: yAixs, width: width, height: heightForCircle))
        viewOne.backgroundColor = UIColor.clearColor()
        viewOne.layer.borderWidth = 1.0
        viewOne.layer.borderColor = UIColor.init(red: 237/255.0, green: 26/255.0, blue: 81/255.0, alpha: 1.0).CGColor
        viewOne.layer.cornerRadius = heightForCircle/2
        viewForCircles.addSubview(viewOne)
        viewOne.hidden = true
        
        xAixs = 0
        yAixs = viewOne.frame.size.height+2
        height = 30
        
        let lblOneTitle = UILabel(frame: CGRect(x: xAixs, y: yAixs, width: width, height: height))
        lblOneTitle.text = ""
        lblOneTitle.textColor = UIColor.init(red: 96/255.0, green: 99/255.0, blue: 107/255.0, alpha: 1.0)
        lblOneTitle.textAlignment = .Center
        lblOneTitle.font = UIFont.systemFontOfSize(12.0)
        lblOneTitle.numberOfLines = 2
        viewForCircles.addSubview(lblOneTitle)
        lblOneTitle.hidden = true
        
        
        height = 30
        xAixs = 10
        yAixs = viewOne.frame.size.height/2-height/2
        width = viewOne.frame.size.width-20
        
        let lblOneTitle_rating = UILabel(frame: CGRect(x: xAixs, y: yAixs, width: width, height: height))
        lblOneTitle_rating.text = ""
        lblOneTitle_rating.textColor = UIColor.whiteColor()
        lblOneTitle_rating.textAlignment = .Center
        lblOneTitle_rating.font = UIFont.systemFontOfSize(13.0)
        lblOneTitle_rating.numberOfLines = 2
        viewOne.addSubview(lblOneTitle_rating)
        lblOneTitle_rating.hidden = true
        
        
        
        
        xAixs = viewOne.frame.size.width+10
        yAixs = 0
        width = viewOne.frame.size.width
        heightForCircle = width
        
        let viewTwo = UIView(frame: CGRect(x: xAixs, y: yAixs, width: width, height: heightForCircle))
        viewTwo.backgroundColor = UIColor.clearColor()
        viewTwo.layer.borderWidth = 1.0
        viewTwo.layer.borderColor = UIColor.init(red: 237/255.0, green: 26/255.0, blue: 81/255.0, alpha: 1.0).CGColor
        viewTwo.layer.cornerRadius = heightForCircle/2
        viewForCircles.addSubview(viewTwo)
        viewTwo.hidden = true
        
        xAixs = viewTwo.frame.origin.x
        yAixs = viewOne.frame.size.height+2
        height = 30
        
        let lblTwoTitle = UILabel(frame: CGRect(x: xAixs, y: yAixs, width: width, height: height))
        lblTwoTitle.text = ""
        lblTwoTitle.textColor = UIColor.init(red: 96/255.0, green: 99/255.0, blue: 107/255.0, alpha: 1.0)
        lblTwoTitle.textAlignment = .Center
        lblTwoTitle.font = UIFont.systemFontOfSize(12.0)
        lblTwoTitle.numberOfLines = 2
        viewForCircles.addSubview(lblTwoTitle)
        lblTwoTitle.hidden = true
        
        height = 30
        xAixs = 10
        yAixs = viewTwo.frame.size.height/2-height/2
        width = viewTwo.frame.size.width-20
        
        let lblTwoTitle_rating = UILabel(frame: CGRect(x: xAixs, y: yAixs, width: width, height: height))
        lblTwoTitle_rating.text = ""
        lblTwoTitle_rating.textColor = UIColor.whiteColor()
        lblTwoTitle_rating.textAlignment = .Center
        lblTwoTitle_rating.font = UIFont.systemFontOfSize(13.0)
        lblTwoTitle_rating.numberOfLines = 2
        viewTwo.addSubview(lblTwoTitle_rating)
        lblTwoTitle_rating.hidden = true
        
        
        
        
        xAixs = viewTwo.frame.size.width+10+viewTwo.frame.origin.x
        yAixs = 0
        width = viewOne.frame.size.width
        heightForCircle = width
        
        let viewThree = UIView(frame: CGRect(x: xAixs, y: yAixs, width: width, height: heightForCircle))
        viewThree.backgroundColor = UIColor.clearColor()
        viewThree.layer.borderWidth = 1.0
        viewThree.layer.borderColor = UIColor.init(red: 237/255.0, green: 26/255.0, blue: 81/255.0, alpha: 1.0).CGColor
        viewThree.layer.cornerRadius = heightForCircle/2
        viewForCircles.addSubview(viewThree)
        viewThree.hidden = true
        
        xAixs = viewThree.frame.origin.x
        yAixs = viewOne.frame.size.height+2
        height = 30
        
        let lblThreeTitle = UILabel(frame: CGRect(x: xAixs, y: yAixs, width: width, height: height))
        lblThreeTitle.text = ""
        lblThreeTitle.textColor = UIColor.init(red: 96/255.0, green: 99/255.0, blue: 107/255.0, alpha: 1.0)
        lblThreeTitle.textAlignment = .Center
        lblThreeTitle.font = UIFont.systemFontOfSize(12.0)
        lblThreeTitle.numberOfLines = 2
        viewForCircles.addSubview(lblThreeTitle)
        lblThreeTitle.hidden = true
        
        height = 30
        xAixs = 10
        yAixs = viewThree.frame.size.height/2-height/2
        width = viewThree.frame.size.width-20
        
        let lblThreeTitle_rating = UILabel(frame: CGRect(x: xAixs, y: yAixs, width: width, height: height))
        lblThreeTitle_rating.text = ""
        lblThreeTitle_rating.textColor = UIColor.whiteColor()
        lblThreeTitle_rating.textAlignment = .Center
        lblThreeTitle_rating.font = UIFont.systemFontOfSize(13.0)
        lblThreeTitle_rating.numberOfLines = 2
        viewThree.addSubview(lblThreeTitle_rating)
        lblThreeTitle_rating.hidden = true
        
        
        
        xAixs = viewThree.frame.size.width+10+viewThree.frame.origin.x
        yAixs = 0
        width = viewOne.frame.size.width
        heightForCircle = width
        
        let viewFour = UIView(frame: CGRect(x: xAixs, y: yAixs, width: width, height: heightForCircle))
        viewFour.backgroundColor = UIColor.clearColor()
        viewFour.layer.borderWidth = 1.0
        viewFour.layer.borderColor = UIColor.init(red: 237/255.0, green: 26/255.0, blue: 81/255.0, alpha: 1.0).CGColor
        viewFour.layer.cornerRadius = heightForCircle/2
        viewForCircles.addSubview(viewFour)
        viewFour.hidden = true
        
        xAixs = viewFour.frame.origin.x
        yAixs = viewOne.frame.size.height+2
        height = 30
    
        let lblFourTitle = UILabel(frame: CGRect(x: xAixs, y: yAixs, width: width, height: height))
        lblFourTitle.text = ""
        lblFourTitle.textColor = UIColor.init(red: 96/255.0, green: 99/255.0, blue: 107/255.0, alpha: 1.0)
        lblFourTitle.textAlignment = .Center
        lblFourTitle.font = UIFont.systemFontOfSize(12.0)
        lblFourTitle.numberOfLines = 2
        viewForCircles.addSubview(lblFourTitle)
        lblFourTitle.hidden = true
        
        
        height = 30
        xAixs = 10
        yAixs = viewFour.frame.size.height/2-height/2
        width = viewFour.frame.size.width-20
        
        let lblFourTitle_rating = UILabel(frame: CGRect(x: xAixs, y: yAixs, width: width, height: height))
        lblFourTitle_rating.text = ""
        lblFourTitle_rating.textColor = UIColor.whiteColor()
        lblFourTitle_rating.textAlignment = .Center
        lblFourTitle_rating.font = UIFont.systemFontOfSize(13.0)
        lblFourTitle_rating.numberOfLines = 2
        viewFour.addSubview(lblFourTitle_rating)
        lblFourTitle_rating.hidden = true
        
        
//        print("self.movie: \(self.movie)")
        
        //Configuring views based on response
        
        let arrayRatings = self.movie.valueForKey("Movierating") as! NSArray//Might crash
        
        for dictRating_ in arrayRatings{
            
            let dictRating = dictRating_ as! NSDictionary
            let indexOfObj = arrayRatings.indexOfObject(dictRating)
            
            if indexOfObj == 0{
                viewOne.hidden = false
                lblOneTitle.hidden = false
                lblOneTitle_rating.hidden = false
                
                let str_webSiteName = dictRating.valueForKey("WebSite_Name") as! String
                lblOneTitle.text = str_webSiteName
                
                let str_rating = "\(String(dictRating.valueForKey("Rating")!))/\(String(dictRating.valueForKey("Rating_Count")!))"
                lblOneTitle_rating.text = str_rating
            }
            if indexOfObj == 1{
                viewTwo.hidden = false
                lblTwoTitle.hidden = false
                lblTwoTitle_rating.hidden = false
                
                let str_webSiteName = dictRating.valueForKey("WebSite_Name") as! String
                lblTwoTitle.text? = str_webSiteName
                
                let str_rating = "\(String(dictRating.valueForKey("Rating")!))/\(String(dictRating.valueForKey("Rating_Count")!))"
                lblTwoTitle_rating.text = str_rating
            }
            if indexOfObj == 2{
                viewThree.hidden = false
                lblThreeTitle.hidden = false
                lblThreeTitle_rating.hidden = false
                
                let str_webSiteName = dictRating.valueForKey("WebSite_Name") as! String
                lblThreeTitle.text = str_webSiteName
                
                let str_rating = "\(String(dictRating.valueForKey("Rating")!))/\(String(dictRating.valueForKey("Rating_Count")!))"
                lblThreeTitle_rating.text = str_rating
            }
            if indexOfObj == 3{
                viewFour.hidden = false
                lblFourTitle.hidden = false
                lblFourTitle_rating.hidden = false
                
                let str_webSiteName = dictRating.valueForKey("WebSite_Name") as! String
                lblFourTitle.text? = str_webSiteName
                
                let str_rating = "\(String(dictRating.valueForKey("Rating")!))/\(String(dictRating.valueForKey("Rating_Count")!))"
                lblFourTitle_rating.text = str_rating
            }
        }
        
        if arrayRatings.count > 0{
            designSynopsis(true)
        }
        else{
            designSynopsis(false)
        }
        
    }
    
    func designSynopsis(isCirclePresent: Bool) {
        
        print("Designing synopsis")
        
        var xAixs:CGFloat = 0
        var yAixs:CGFloat = 0
        if isCirclePresent{
            yAixs = viewForCircles.frame.size.height+viewForCircles.frame.origin.y+20
        }
        else{
            yAixs = castTitle.frame.size.height+castTitle.frame.origin.y+20
        }
        var width:CGFloat = scrollView.frame.size.width
        var height:CGFloat = 100
        
        viewForSynopsis = UIView(frame: CGRect(x: xAixs, y: yAixs, width: width, height: height))
        viewForSynopsis.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(viewForSynopsis)
        
        let viewBorder = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: viewForSynopsis.frame.size.height))
        viewBorder.backgroundColor = UIColor.init(red: 225/255.0, green: 225/255.0, blue: 227/255.0, alpha: 1.0)
        viewForSynopsis.addSubview(viewBorder)
        
        height = 20
        xAixs = 20
        yAixs = 10
        width = viewForSynopsis.frame.size.width-20
        
        let lblSynopsisTitle = UILabel(frame: CGRect(x: xAixs, y: yAixs, width: width, height: height))
        lblSynopsisTitle.text = "SYNOPSIS:"
        lblSynopsisTitle.font = UIFont.systemFontOfSize(11.0)
        lblSynopsisTitle.autoresize()
        lblSynopsisTitle.backgroundColor = UIColor.clearColor()
        viewForSynopsis.addSubview(lblSynopsisTitle)
        
        height = viewForSynopsis.frame.size.height-(lblSynopsisTitle.frame.origin.x+lblSynopsisTitle.frame.size.height)
        xAixs = 20
        yAixs = lblSynopsisTitle.frame.origin.x+lblSynopsisTitle.frame.size.height
        width = viewForSynopsis.frame.size.width-25
        
        let lblSynopsisDescription = UILabel(frame: CGRect(x: xAixs, y: yAixs-5, width: width, height: height))
        lblSynopsisDescription.text = self.movie["Description"] as? String
        lblSynopsisDescription.font = UIFont.systemFontOfSize(11.0)
        lblSynopsisDescription.numberOfLines = 10
        lblSynopsisDescription.autoresize()
        lblSynopsisDescription.backgroundColor = UIColor.clearColor()
        viewForSynopsis.addSubview(lblSynopsisDescription)
        
        
        viewForSynopsis.frame = CGRectMake(viewForSynopsis.frame.origin.x, viewForSynopsis.frame.origin.y, viewForSynopsis.frame.width, lblSynopsisDescription.frame.height+40)
        viewBorder.frame = CGRectMake(viewBorder.frame.origin.x, viewBorder.frame.origin.y, viewBorder.frame.width, viewForSynopsis.frame.height)
        
        designSegment()
    }
    
    func designSegment() {
        
        //viewForSynopsis
        let viewMainSegment = UIView()
        viewMainSegment.frame = CGRectMake(0, viewForSynopsis.frame.origin.y+viewForSynopsis.frame.size.height, scrollView.frame.size.width, 60)
        viewMainSegment.backgroundColor = UIColor.clearColor()
        scrollView.addSubview(viewMainSegment)
        
        //Trainler designs
        buttonTraileres = UIButton(type: .Custom)
        buttonTraileres.frame = CGRectMake(0, 0, viewMainSegment.frame.size.width/3, viewMainSegment.frame.size.height)
        buttonTraileres.backgroundColor = UIColor.clearColor()
        buttonTraileres.addTarget(self, action: #selector(MoviesDetailVC.buttonTraileresEvent(_:)), forControlEvents: .TouchUpInside)
        viewMainSegment.addSubview(buttonTraileres)
        
        let viewForImageAndTitle_ratings = UIView()
        viewForImageAndTitle_ratings.userInteractionEnabled = false
        viewForImageAndTitle_ratings.frame = CGRectMake((buttonTraileres.frame.size.width/2)-((buttonTraileres.frame.size.width-30)/2), 7, buttonTraileres.frame.size.width-30, buttonTraileres.frame.size.height-15)
        viewForImageAndTitle_ratings.backgroundColor = UIColor.clearColor()
        buttonTraileres.addSubview(viewForImageAndTitle_ratings)
        
        imageIcon_trailers = UIImageView()
        imageIcon_trailers.frame = CGRectMake(0, 0, viewForImageAndTitle_ratings.frame.size.width/5, viewForImageAndTitle_ratings.frame.size.height)
        imageIcon_trailers.image = UIImage(named: "trailers_selected_icon")
        imageIcon_trailers.clipsToBounds = true
        imageIcon_trailers.contentMode = .ScaleAspectFit
        viewForImageAndTitle_ratings.addSubview(imageIcon_trailers)
        
        lblTrailersText = UILabel()
        lblTrailersText.text = "TRAILERS"
        lblTrailersText.font = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
        lblTrailersText.frame = CGRectMake(imageIcon_trailers.frame.size.width+5, 0, viewForImageAndTitle_ratings.frame.size.width-imageIcon_trailers.frame.size.width, viewForImageAndTitle_ratings.frame.size.height)
        lblTrailersText.textColor = UIColor.init(red: 234/255.0, green: 27/255.0, blue: 80/255.0, alpha: 1.0)
        lblTrailersText.textAlignment = .Center
        viewForImageAndTitle_ratings.addSubview(lblTrailersText)
        
        viewTrailers = UIView(frame: CGRectMake(0,viewMainSegment.frame.origin.y+viewMainSegment.frame.size.height,scrollView.frame.size.width,300))
        viewTrailers.backgroundColor = UIColor.clearColor()
        viewTrailers.hidden = false
        scrollView.addSubview(viewTrailers)

        
        let aryMovieVideos = movie.valueForKey( "MovieVideos") as! NSArray
        
        viewCasting.frame = CGRectMake(0,viewMainSegment.frame.origin.y+viewMainSegment.frame.size.height,scrollView.frame.size.width,(scrollView.frame.size.width/2)*(CGFloat(aryMovieVideos.count)/2))
        
        var yAxis:CGFloat = 0
        var xAxis:CGFloat = 0
        
        var indexNum = 0
        
        for dictItem in aryMovieVideos{
            
            if(indexNum%2 == 0){
                yAxis = viewTrailers.frame.size.width/2*CGFloat(indexNum/2)
            }
            
            let viewForWeb = UIView()
            viewForWeb.frame = CGRect(x: xAxis, y: yAxis, width: viewTrailers.frame.size.width/2, height: viewTrailers.frame.size.width/2)
            viewForWeb.backgroundColor = UIColor.clearColor()
            viewForWeb.clipsToBounds = true
            viewTrailers.addSubview(viewForWeb)
            
            if xAxis == 0{
                xAxis = viewTrailers.frame.size.width/2
            }
            else{
               xAxis = 0
            }
            
            let imgViewThubmnail = UIImageView()
            imgViewThubmnail.frame = viewForWeb.bounds
            
            let dictTrailerItem = dictItem as! NSDictionary
            if let item = dictTrailerItem.valueForKey("Thumbnail") as? String {
                
                if item != "<null>"{
                    let str_trailarurl = item //dictTrailerItem.valueForKey("Artists_Pic") as! String
                    if str_trailarurl.characters.count >= 8{
                        let ecodedURL = str_trailarurl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
                        imgViewThubmnail.kf_setImageWithURL(NSURL(string: ecodedURL!))
                    }
                    else{
                        imgViewThubmnail.image = UIImage(named: "Placeholder_male")
                    }
                }
                else{
                    imgViewThubmnail.image = UIImage(named: "Placeholder_male")
                }
            }
            else{
                imgViewThubmnail.image = UIImage(named: "Placeholder_male")
            }
            
            imgViewThubmnail.userInteractionEnabled = true
            viewForWeb.addSubview(imgViewThubmnail)
            
            let buttonThumbnail = UIButton(type: .Custom)
            buttonThumbnail.frame = viewForWeb.bounds
            buttonThumbnail.backgroundColor = UIColor.clearColor()
            buttonThumbnail.tag = aryMovieVideos.indexOfObject(dictItem) as Int
            buttonThumbnail.addTarget(self, action: #selector(MoviesDetailVC.trailerTappedEvent(_:)), forControlEvents: .TouchUpInside)
            viewForWeb.addSubview(buttonThumbnail)
            
            indexNum += 1
        }
        
        
        //Photogralley designs
        buttonPhotoGralley = UIButton(type: .Custom)
        buttonPhotoGralley.frame = CGRectMake(buttonTraileres.frame.size.width, 0, viewMainSegment.frame.size.width/3, viewMainSegment.frame.size.height)
        buttonPhotoGralley.backgroundColor = UIColor.clearColor()
        buttonPhotoGralley.addTarget(self, action: #selector(MoviesDetailVC.buttonPhotoGalleryEvent(_:)), forControlEvents: .TouchUpInside)
        viewMainSegment.addSubview(buttonPhotoGralley)
        
        let viewForImageAndTitle_photoGralley = UIView()
        viewForImageAndTitle_photoGralley.userInteractionEnabled = false
        viewForImageAndTitle_photoGralley.frame = CGRectMake((buttonTraileres.frame.size.width/2)-((buttonTraileres.frame.size.width-30)/2), 7, buttonTraileres.frame.size.width-30, buttonTraileres.frame.size.height-15)
        viewForImageAndTitle_photoGralley.backgroundColor = UIColor.clearColor()
        buttonPhotoGralley.addSubview(viewForImageAndTitle_photoGralley)
        
        imageIcon_PhotoGallery = UIImageView()
        imageIcon_PhotoGallery.frame = CGRectMake(0, 0, viewForImageAndTitle_photoGralley.frame.size.width/5, viewForImageAndTitle_photoGralley.frame.size.height)
        imageIcon_PhotoGallery.image = UIImage(named: "movieGallery_icon")
        imageIcon_PhotoGallery.clipsToBounds = true
        imageIcon_PhotoGallery.contentMode = .ScaleAspectFit
        viewForImageAndTitle_photoGralley.addSubview(imageIcon_PhotoGallery)
        
        lblPhotoGralleyText = UILabel()
        lblPhotoGralleyText.text = "PHOTO \nGALLERY"
        lblPhotoGralleyText.numberOfLines = 2
        lblPhotoGralleyText.font = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
        lblPhotoGralleyText.frame = CGRectMake(imageIcon_PhotoGallery.frame.size.width+5, 0, viewForImageAndTitle_photoGralley.frame.size.width-imageIcon_PhotoGallery.frame.size.width, viewForImageAndTitle_photoGralley.frame.size.height)
        lblPhotoGralleyText.textAlignment = .Center
        lblPhotoGralleyText.textColor = UIColor.whiteColor()//UIColor.init(red: 234/255.0, green: 27/255.0, blue: 80/255.0, alpha: 1.0)
        viewForImageAndTitle_photoGralley.addSubview(lblPhotoGralleyText)
        
        viewPhotoGralley = UIView(frame: CGRectMake(0,viewMainSegment.frame.origin.y+viewMainSegment.frame.size.height,scrollView.frame.size.width,300))
        viewPhotoGralley.backgroundColor = UIColor.clearColor()
        viewPhotoGralley.hidden = true
        scrollView.addSubview(viewPhotoGralley)
        
        let aryPhotoGallery = movie.valueForKey( "MovieImages") as! NSArray
        
        viewCasting.frame = CGRectMake(0,viewMainSegment.frame.origin.y+viewMainSegment.frame.size.height,scrollView.frame.size.width,(scrollView.frame.size.width/2)*(CGFloat(aryPhotoGallery.count)/2))
        
        yAxis = 0
        xAxis = 0
        
        indexNum = 0
        
        for dictItem in aryPhotoGallery{
            
            if(indexNum%2 == 0){
                yAxis = viewPhotoGralley.frame.size.width/2*CGFloat(indexNum/2)
            }
            
            let viewForWeb = UIView()
            viewForWeb.frame = CGRect(x: xAxis, y: yAxis, width: viewPhotoGralley.frame.size.width/2, height: viewPhotoGralley.frame.size.width/2)
            viewForWeb.backgroundColor = UIColor.clearColor()
            viewForWeb.clipsToBounds = true
            viewPhotoGralley.addSubview(viewForWeb)
            
            if xAxis == 0{
                xAxis = viewPhotoGralley.frame.size.width/2
            }
            else{
                xAxis = 0
            }
            
            let imgViewThubmnail = UIImageView()
            imgViewThubmnail.frame = viewForWeb.bounds
            
            let dictTrailerItem = dictItem as! NSDictionary
            if let item = dictTrailerItem.valueForKey("IMG_Code") as? String {
                
                if item != "<null>"{
                    let str_trailarurl = item //dictTrailerItem.valueForKey("Artists_Pic") as! String
                    if str_trailarurl.characters.count >= 8{
                        let ecodedURL = str_trailarurl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
                        imgViewThubmnail.kf_setImageWithURL(NSURL(string: ecodedURL!))
                    }
                    else{
                        imgViewThubmnail.image = UIImage(named: "Placeholder_male")
                    }
                }
                else{
                    imgViewThubmnail.image = UIImage(named: "Placeholder_male")
                }
            }
            else{
                imgViewThubmnail.image = UIImage(named: "Placeholder_male")
            }
            
            imgViewThubmnail.userInteractionEnabled = true
            viewForWeb.addSubview(imgViewThubmnail)
            
            indexNum += 1
        }
        
        
        //Casting designs
        buttonCasting = UIButton(type: .Custom)
        buttonCasting.frame = CGRectMake(buttonPhotoGralley.frame.origin.x+buttonPhotoGralley.frame.size.width, 0, viewMainSegment.frame.size.width/3, viewMainSegment.frame.size.height)
        buttonCasting.backgroundColor = UIColor.clearColor()
        buttonCasting.addTarget(self, action: #selector(MoviesDetailVC.buttonCastingEvent(_:)), forControlEvents: .TouchUpInside)
        viewMainSegment.addSubview(buttonCasting)
        
        let viewForImageAndTitle_Casting = UIView()
        viewForImageAndTitle_Casting.userInteractionEnabled = false
        viewForImageAndTitle_Casting.frame = CGRectMake((buttonCasting.frame.size.width/2)-((buttonCasting.frame.size.width-30)/2), 7, buttonCasting.frame.size.width-30, buttonCasting.frame.size.height-15)
        viewForImageAndTitle_Casting.backgroundColor = UIColor.clearColor()
        buttonCasting.addSubview(viewForImageAndTitle_Casting)
        
        imageIcon_casting = UIImageView()
        imageIcon_casting.frame = CGRectMake(0, 0, viewForImageAndTitle_Casting.frame.size.width/5, viewForImageAndTitle_Casting.frame.size.height)
        imageIcon_casting.image = UIImage(named: "casting_icon")
        imageIcon_casting.clipsToBounds = true
        imageIcon_casting.contentMode = .ScaleAspectFit
        viewForImageAndTitle_Casting.addSubview(imageIcon_casting)
        
        lblCastingText = UILabel()
        lblCastingText.text = "CASTING"
        lblCastingText.numberOfLines = 2
        lblCastingText.font = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
        lblCastingText.frame = CGRectMake(imageIcon_casting.frame.size.width+5, 0, viewForImageAndTitle_Casting.frame.size.width-imageIcon_casting.frame.size.width, viewForImageAndTitle_Casting.frame.size.height)
        lblCastingText.textColor = UIColor.whiteColor()//UIColor.init(red: 234/255.0, green: 27/255.0, blue: 80/255.0, alpha: 1.0)
        lblCastingText.textAlignment = .Center
        viewForImageAndTitle_Casting.addSubview(lblCastingText)
        
        viewCasting = UIView(frame: CGRectMake(0,viewMainSegment.frame.origin.y+viewMainSegment.frame.size.height,scrollView.frame.size.width,300))
        viewCasting.backgroundColor = UIColor.clearColor()
        viewCasting.hidden = true
        scrollView.addSubview(viewCasting)
        
        let aryCasting = movie.valueForKey( "MovieArtists") as! NSArray
        
        viewCasting.frame = CGRectMake(0,viewMainSegment.frame.origin.y+viewMainSegment.frame.size.height,scrollView.frame.size.width,(scrollView.frame.size.width/2)*(CGFloat(aryCasting.count+1)/2))
        
        yAxis = 0
        xAxis = 0
        
        indexNum = 0
        
        for dictItem in aryCasting{
            
            
            if(indexNum%2 == 0){
                yAxis = viewCasting.frame.size.width/2*CGFloat(indexNum/2)
            }
            
            let viewForWeb = UIView()
            viewForWeb.frame = CGRect(x: xAxis, y: yAxis, width: viewCasting.frame.size.width/2, height: viewCasting.frame.size.width/2)
            viewForWeb.backgroundColor = UIColor.clearColor()
            viewForWeb.clipsToBounds = true
            viewCasting.addSubview(viewForWeb)
            
            if xAxis == 0{
                xAxis = viewCasting.frame.size.width/2
            }
            else{
                xAxis = 0
            }
            
            let imgViewThubmnail = UIImageView()
            imgViewThubmnail.frame = viewForWeb.bounds
            
            imgViewThubmnail.image = UIImage(named: "Placeholder_male")
            
            let dictTrailerItem = dictItem as! NSDictionary
            if let item = dictTrailerItem.valueForKey("Artists_Pic") as? String {
                
                if item != "<null>"{
                    let str_trailarurl = item //dictTrailerItem.valueForKey("Artists_Pic") as! String
                    if str_trailarurl.characters.count >= 8{
                        let ecodedURL = str_trailarurl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
                        imgViewThubmnail.kf_setImageWithURL(NSURL(string: ecodedURL!))
                    }
                    else{
                        imgViewThubmnail.image = UIImage(named: "Placeholder_male")
                    }
                }
                else{
                    imgViewThubmnail.image = UIImage(named: "Placeholder_male")
                }
            }
            else{
                imgViewThubmnail.image = UIImage(named: "Placeholder_male")
            }
            
            imgViewThubmnail.userInteractionEnabled = true
            viewForWeb.addSubview(imgViewThubmnail)
            
            
            let lblProfession = UILabel()
            lblProfession.frame = CGRectMake(5, imgViewThubmnail.frame.size.height-30, imgViewThubmnail.frame.size.width-10, 30)
            if let artistName = dictTrailerItem.valueForKey("Profession") as? String{
                lblProfession.text = artistName
            }
            lblProfession.backgroundColor = UIColor.clearColor()
            lblProfession.textColor = UIColor.init(red: 237/255.0, green: 26/255.0, blue: 81/255.0, alpha: 1.0)
            lblProfession.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
            lblProfession.textAlignment = .Left
            lblProfession.numberOfLines = 2
            lblProfession.autoresize()
            imgViewThubmnail.addSubview(lblProfession)
            
            let lblArtistName = UILabel()
            lblArtistName.frame = CGRectMake(5, lblProfession.frame.origin.y-lblProfession.frame.size.height, imgViewThubmnail.frame.size.width-10, 60)
            if let artistName = dictTrailerItem.valueForKey("Artists_Name") as? String{
                lblArtistName.text = artistName
            }
            lblArtistName.textColor = UIColor.whiteColor()
            lblArtistName.backgroundColor = UIColor.clearColor()
            lblArtistName.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
            lblArtistName.textAlignment = .Left
            lblArtistName.numberOfLines = 2
            lblArtistName.layer.shadowColor = UIColor.blackColor().CGColor
            lblArtistName.autoresize()
            imgViewThubmnail.addSubview(lblArtistName)
            
            lblArtistName.frame = CGRectMake(5, lblProfession.frame.origin.y-lblArtistName.frame.size.height, imgViewThubmnail.frame.size.width-10, lblArtistName.frame.size.height)
            
            
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.colors = [UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 0.0).CGColor, UIColor.init(red: 22/255.0, green: 23/255.0, blue: 27/255.0, alpha: 0.4).CGColor]
            gradient.frame = CGRect(x: 0.0, y: viewForWeb.frame.size.width/2, width: viewForWeb.frame.size.width, height: viewForWeb.frame.size.height/2)
            imgViewThubmnail.layer.insertSublayer(gradient, atIndex: 0)
            
            indexNum += 1
        }
        
        
        //Setting scrollContent size 
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: viewTrailers.frame.origin.y+viewTrailers.frame.size.height+20)
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
        
        let str_movieID = String(self.movie.valueForKey("Mov_ID")!)
        
        if let locationDetails = UserDefaultsStore.userDefaults.valueForKey("Location_ID") as? NSDictionary{
            
            if let locationID_id = locationDetails.valueForKey("Location_ID") as? Int {
                
                let locationID_str = String(locationID_id)
                self.getBookingDetails(str_movieID, locationID: locationID_str)
            }
            else{
                print("Booking details not found")
                
                let alertView_ = UIAlertView(title: "City Movies", message: "No bookings found for this movie.", delegate: nil, cancelButtonTitle: "Ok")
                alertView_.show()
            }
            
        }
        else{
            print("Booking Location_ID details not found")
            
            let alertView_ = UIAlertView(title: "City Movies", message: "Please select a location from \"Profile\"", delegate: nil, cancelButtonTitle: "Ok")
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
        localArray = movie.valueForKey( "MovieImages") as! NSArray
//        var xAxis :CGFloat = 0
        for (index,obj) in localArray.enumerate() {
            let dict = obj as! NSDictionary
            let sstr : NSString = NSString(format: "%@",dict["IMG_Code"] as! String)//http://img.youtube.com/vi/%@/hqdefault.jpg
            photosurlsArray.addObject(sstr)
            
        }
        
        self.view.layoutIfNeeded()
    }
    
    //MARK: - Segment Events
    func buttonTraileresEvent(sender: UIButton) {
        
        print("Trailers selected")
        
        imageIcon_trailers.image = UIImage(named: "trailers_selected_icon")
        imageIcon_PhotoGallery.image = UIImage(named: "movieGallery_icon")
        imageIcon_casting.image = UIImage(named: "casting_icon")
        
        lblTrailersText.textColor = UIColor.init(red: 234/255.0, green: 27/255.0, blue: 80/255.0, alpha: 1.0)
        lblPhotoGralleyText.textColor = UIColor.whiteColor()
        lblCastingText.textColor = UIColor.whiteColor()
        
        viewTrailers.hidden = false
        viewPhotoGralley.hidden = true
        viewCasting.hidden = true
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: viewTrailers.frame.origin.y+viewTrailers.frame.size.height+20)
    }
    
    func buttonPhotoGalleryEvent(sender: UIButton) {
        
        print("PhotoGallery selected")
        imageIcon_trailers.image = UIImage(named: "trailers_icon")
        imageIcon_PhotoGallery.image = UIImage(named: "movieGallery_selected_icon")
        imageIcon_casting.image = UIImage(named: "casting_icon")
        
        lblTrailersText.textColor = UIColor.whiteColor()
        lblPhotoGralleyText.textColor = UIColor.init(red: 234/255.0, green: 27/255.0, blue: 80/255.0, alpha: 1.0)
        lblCastingText.textColor = UIColor.whiteColor()
        
        viewTrailers.hidden = true
        viewPhotoGralley.hidden = false
        viewCasting.hidden = true
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: viewPhotoGralley.frame.origin.y+viewPhotoGralley.frame.size.height+20)
    }
    
    func buttonCastingEvent(sender: UIButton) {
        
        print("Casting selected")
        imageIcon_trailers.image = UIImage(named: "trailers_icon")
        imageIcon_PhotoGallery.image = UIImage(named: "movieGallery_icon")
        imageIcon_casting.image = UIImage(named: "casting_selected_icon")
        
        lblTrailersText.textColor = UIColor.whiteColor()
        lblPhotoGralleyText.textColor = UIColor.whiteColor()
        lblCastingText.textColor = UIColor.init(red: 234/255.0, green: 27/255.0, blue: 80/255.0, alpha: 1.0)
        
        viewTrailers.hidden = true
        viewPhotoGralley.hidden = true
        viewCasting.hidden = false
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: viewCasting.frame.origin.y+viewCasting.frame.size.height+20)
    }
    
    func trailerTappedEvent(sender: UIButton) {
        
        print("Trailer tapped at index: \(sender.tag)")
        
        let aryMovieVideos = movie.valueForKey( "MovieVideos") as! NSArray
        
        let dictItem = aryMovieVideos[sender.tag] as! NSDictionary
        let strURL = dictItem.valueForKey("URL") as! String
        
        let webView = TOWebViewController(URL: NSURL(string: strURL))
        let navVC = UINavigationController(rootViewController: webView)
        self.presentViewController(navVC, animated: true, completion: nil)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
    }
    
    //MARK: - Getting booking details
    func getBookingDetails(movieID: String, locationID: String) {
        print("MovieID: \(movieID) LocationID: \(locationID)")
        
        //Adding activity view to self.view
        if ARSLineProgress.shown { return }
        ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.userInteractionEnabled = false
        
        
        let url_ = NSURL(string: "http://citymoviesapi.bananaapps.co.in/api/MovieBooking/MovieBooking")
        
        let request = NSMutableURLRequest(URL: url_!)
        request.HTTPMethod = "POST"
        
        let json = [ "Mov_ID":movieID , "Location_ID": locationID]
        
        do {
            let jsonResult = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            request.HTTPBody = jsonResult
            print("dictionar \(jsonResult)")
        } catch let error as NSError {
            print("error in constructing dictionar: \(error.localizedDescription)")
        }
        
        
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        
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
                            
                            let arrayMovieBookingDetails = json.valueForKey("MovieBooking") as! NSArray
                            
                            if arrayMovieBookingDetails.count != 0{
                                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                                
                                if let bookingVC = storyBoard.instantiateViewControllerWithIdentifier("BookVCStoryboardID") as? BookVC {
                                    bookingVC.navigRef = self.navigCRef
                                    bookingVC.movie = self.movie
                                    bookingVC.arrayMovieBookingList = arrayMovieBookingDetails
                                    dispatch_async(dispatch_get_main_queue()) {
                                        self.navigCRef?.pushViewController(bookingVC, animated: false)
                                    }
                                }
                            }
                            else{
                                dispatch_async(dispatch_get_main_queue()) {
                                    let alertView_ = UIAlertView(title: "City Movies", message: "No bookings found for this movie.", delegate: nil, cancelButtonTitle: "Ok")
                                    alertView_.show()
                                }
                            }
                            
                            
                        } else if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
                            // process "json" as an array
                            print("\(json)")
                            
                        } else {
                            print("Error could not parse movies JSON string:")
                            dispatch_async(dispatch_get_main_queue()) {
                                let alertView_ = UIAlertView(title: "City Movies", message: "No bookings found for this movie.", delegate: nil, cancelButtonTitle: "Ok")
                                alertView_.show()
                            }
                        }
                        
                    } catch {
                        print("error serializing movies JSON: \(error)")
                        dispatch_async(dispatch_get_main_queue()) {
                            let alertView_ = UIAlertView(title: "City Movies", message: "No bookings found for this movie.", delegate: nil, cancelButtonTitle: "Ok")
                            alertView_.show()
                        }
                    }
                }
                else{
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        let alertView_ = UIAlertView(title: "City Movies", message: "No bookings found for this movie.", delegate: nil, cancelButtonTitle: "Ok")
                        alertView_.show()
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
}




//MARK: - Updating movie details

extension UILabel {
    
    func autoresize() {
        if let textNSString: NSString = self.text as NSString? {
            
            let rect = textNSString.boundingRectWithSize(CGSize(width: self.frame.size.width, height: CGFloat.max),
                                                         options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                         attributes: [NSFontAttributeName: self.font],
                                                         context: nil)
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: rect.height+3)
        }
    }
}
