//
//  LaunchViewController.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 03/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    var isUserLoggedIn:Bool = false
    
    override func viewWillAppear(animated: Bool) {
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.blackColor()
        
        //Adding background image
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "loginBackground")?.drawInRect(self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor.init(patternImage: image!)
        
//        print("Username: \(UserDefaultsStore.userDefaults.objectForKey(UserDefaultsKeys.kUserNameKey)!)")
//        print("Password: \(UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kPasswordKey)!)")
        
        
        var strSkipEvet:String = ""
        if((UserDefaultsStore.userDefaults.valueForKey( UserDefaultsKeys.kSkipEvent)) != nil)
        {
            strSkipEvet = UserDefaultsStore.userDefaults.valueForKey( UserDefaultsKeys.kSkipEvent) as! String
        }
        
        if(strSkipEvet == "true")
        {
            print("Proceed to main screen")
            isUserLoggedIn = true
            print("Showing Main screen")
            
            UserDefaultsStore.userDefaults.setValue("false", forKey: UserDefaultsKeys.kSkipEvent)
            
            launchMainScreen()
        }
        else
        {
            if (FBSDKAccessToken.currentAccessToken() != nil)
            {
                // User is already logged in, do work such as go to next view controller.
                print("Proceed to main screen")
                isUserLoggedIn = true
                print("Showing Main screen")
                launchMainScreen()
                
            }
            else if((UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kUserNameKey)) != nil && (UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kPasswordKey)) != nil){
                
                var strUserName:String! = UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kUserNameKey) as! String
                var strUserPassword:String! = UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kPasswordKey) as! String
                
                strUserName = strUserName.stringByReplacingOccurrencesOfString("Optional(", withString: "")
                strUserName = strUserName.stringByReplacingOccurrencesOfString(")", withString: "")
                
                strUserPassword = strUserPassword.stringByReplacingOccurrencesOfString("Optional(", withString: "")
                strUserPassword = strUserPassword.stringByReplacingOccurrencesOfString(")", withString: "")
                
                if((strUserName.characters.count>5) && (strUserPassword.characters.count>4)){
                    print("Proceed to main screen")
                    isUserLoggedIn = true
                    print("Showing Main screen")
                    launchMainScreen()
                    
                    //            self.performSegueWithIdentifier("LaunchToMain", sender: nil)
                }
                else{
                    isUserLoggedIn = false
                    self.navigationController?.navigationBarHidden = true
                    self.performSegueWithIdentifier("LaunchToLogin", sender: nil)
                }
                
            }
            else
            {
                isUserLoggedIn = false
                self.navigationController?.navigationBarHidden = true
//                self.performSegue(withIdentifier: "LaunchToLogin", sender: nil)
                self.performSegueWithIdentifier("LaunchToLogin", sender: nil)
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    //MARK: - Launch main screen event
    func launchMainScreen() {
        
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.navigationController?.navigationItem.backBarButtonItem = nil
        
        let menuViewController = MenuViewController()
        menuViewController.title = "MenuViewController"
        let ctr1 = MovieViewController()
        ctr1.title = "Movies"
        let ctr2 = TheatersViewController()
        ctr2.title = "Theaters"
        let ctr3 = UpComingViewController()
        ctr3.title = "Upcoming"
        
        //            var img1 = UIImage(named: "gear")
        //            img1 = img1?.imageWithRenderingMode(.AlwaysTemplate)
        //            var img2 = UIImage(named: "profile")
        //            img2 = img2?.imageWithRenderingMode(.AlwaysTemplate)
        //            var img3 = UIImage(named: "chat")
        //            img3 = img3?.imageWithRenderingMode(.AlwaysTemplate)
        
        let viewMenu = UIView(frame: CGRect(x: 0,y: 0,width: 84,height: 36))
        viewMenu.backgroundColor = UIColor.clearColor()
        
//        let imgViewMenu = UIImageView(frame: CGRectMake(viewMenu.frame.size.width/2-25/2,0,20,20))
//        imgViewMenu.image = UIImage(named: "profile_icon")
//        viewMenu.addSubview(imgViewMenu)
        
        let lblMenu = UILabel(frame: CGRect(x: 0,y: 0,width: viewMenu.frame.size.width,height: 40))
        lblMenu.text = "PROFILE"
        lblMenu.font = UIFont.boldSystemFontOfSize( 12.0)
        lblMenu.textAlignment = NSTextAlignment.Center
        lblMenu.textColor = UIColor.whiteColor()
        viewMenu.addSubview(lblMenu)
        
        
        let viewMovies = UIView(frame: CGRect(x: 0,y: 0,width: 64,height: 36))
        viewMovies.backgroundColor = UIColor.clearColor()
        
//        let imgViewMovies = UIImageView(frame: CGRectMake(viewMovies.frame.size.width/2-25/2,0,20,20))
//        imgViewMovies.image = UIImage(named: "Movies_icon")
//        viewMovies.addSubview(imgViewMovies)
        
        let lblMovies = UILabel(frame: CGRect(x: 0,y: 0,width: viewMovies.frame.size.width,height: 40))
        lblMovies.text = "MOVIES"
        lblMovies.font = UIFont.boldSystemFontOfSize( 12.0)
        lblMovies.textAlignment = NSTextAlignment.Center
        lblMovies.textColor = UIColor.whiteColor()
        viewMovies.addSubview(lblMovies)
        
        
        let viewTheaters = UIView(frame: CGRect(x: 0,y: 0,width: 64,height: 36))
        viewTheaters.backgroundColor = UIColor.clearColor()
        
//        let imgViewTheaters = UIImageView(frame: CGRectMake(viewMovies.frame.size.width/2-25/2,0,20,20))
//        imgViewTheaters.image = UIImage(named: "Theaters_icon")
//        viewTheaters.addSubview(imgViewTheaters)
        
        let lblTheaters = UILabel(frame: CGRect(x: 0,y: 0,width: viewMovies.frame.size.width,height: 40))
        lblTheaters.text = "THEATRES"
        lblTheaters.font = UIFont.boldSystemFontOfSize( 12.0)
        lblTheaters.textAlignment = NSTextAlignment.Center
        lblTheaters.textColor = UIColor.whiteColor()
        viewTheaters.addSubview(lblTheaters)
        
        
        let viewUpComing = UIView(frame: CGRect(x: 0,y: 0,width: 84,height: 36))
        viewUpComing.backgroundColor = UIColor.clearColor()
        
//        let imgUpComing = UIImageView(frame: CGRectMake(viewMovies.frame.size.width/2-25/2,0,20,20))
//        imgUpComing.image = UIImage(named: "Movies_icon")
//        viewUpComing.addSubview(imgUpComing)
        
        let lblUpComing = UILabel(frame: CGRect(x: 0,y: 0,width: viewUpComing.frame.size.width,height: 40))
        lblUpComing.text = "UPCOMING"
        lblUpComing.font = UIFont.boldSystemFontOfSize( 12.0)
        lblUpComing.textAlignment = NSTextAlignment.Center
        lblUpComing.textColor = UIColor.whiteColor()
        viewUpComing.addSubview(lblUpComing)
        
        let items = [viewMenu,viewMovies, viewTheaters, viewUpComing]
        
        let controllers = [menuViewController,ctr1, ctr2, ctr3]
        
        let controller = SLPagingViewSwift(items: items, controllers: controllers, showPageControl: false)
        controller.navigationSideItemsStyle = SLNavigationSideItemsStyle.SLNavigationSideItemsStyleFar
        let whitecolor = UIColor.whiteColor()
        let greencolor = UIColor(red: 27/255, green: 207/255, blue: 240/255, alpha: 1.0)
//        controller.pagingViewMoving = ({ subviews in
//            let viewsOfPage:NSArray = subviews
//            
//            for imgView in viewsOfPage {
//                var c = whitecolor
//                let originX = Double(imgView.frame.origin.x)
//                
//                if (originX > 45 && originX < 145) {
//                    c = self.gradient(originX, topX: 46, bottomX: 144, initC: greencolor, goal: whitecolor)
//                }
//                if(originX == 145){
//                    c = greencolor
//                }
//                let viewElement = imgView as! UIView
//                for case let lbl as UILabel in viewElement.subviews {
//                    lbl.textColor = c
//                }
//            }
//        })
        
        //        let indexToShow:Int = 1
        //        controller.setCurrentIndex(indexToShow, animated: false)
        
        menuViewController.navigRefe = self.navigationController
        menuViewController.controlRefe = controller
        
        ctr1.navigRef = self.navigationController
        ctr1.controlRef = controller
        
        ctr2.navigRef = self.navigationController
        ctr2.controlRef = controller
        
        ctr3.navigRef = self.navigationController
        ctr3.controlRef = controller
        
        controller.navigationController?.navigationBarHidden = true
        controller.navigationItem.hidesBackButton = true
        controller.navigationController?.navigationItem.hidesBackButton = true
        controller.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        
        
                SLPagingViewDidChanged.self
                controller.didChangedPage2 = ({ currentIndex in
                    print("Current Index: \(currentIndex)")
        
                    if currentIndex == 0{
//                        NSNotificationCenter.defaultCenter().postNotificationName("ScrolledToPageZero", object: nil)
                    }
                    if currentIndex == 1{
                        NSNotificationCenter.defaultCenter().postNotificationName("ScrolledToPageMovies", object: nil)
                    }
                    if currentIndex == 2{
//                        NSNotificationCenter.defaultCenter().postNotificationName("ScrolledToPageTheaters", object: nil)
                    }
                    if currentIndex == 3{
                        NSNotificationCenter.defaultCenter().postNotificationName("ScrolledToPageUpcoming", object: nil)
                    }
                })
        
        
        
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    
    //MARK - Setting gradient
//    func gradient(percent: Double, topX: Double, bottomX: Double, initC: UIColor, goal: UIColor) -> UIColor{
//        let t = (percent - bottomX) / (topX - bottomX)
//        
//        let cgInit = initC.cgColor.components
//        let cgGoal = goal.cgColor.components
//        
//        let r = cgInit[0] + CGFloat(t) * (cgGoal[0] - cgInit[0])
//        let g = cgInit[1] + CGFloat(t) * (cgGoal[1] - cgInit[1])
//        let b = cgInit[2] + CGFloat(t) * (cgGoal[2] - cgInit[2])
//        
//        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
//    }
    
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
