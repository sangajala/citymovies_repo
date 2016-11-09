//
//  SignUpViewController.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 04/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var textFieldUserName = UITextField()
    var textFieldPassword = UITextField()
    var lblValidation = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("Testing Goutham_work commit")
        
        self.view.backgroundColor = UIColor.blackColor()
        
        self.navigationController?.navigationBarHidden = true
        
        //Adding background image
        var width:CGFloat = self.view.frame.width
        var height:CGFloat = self.view.frame.height
        var xAxis:CGFloat = 0
        var yAxis:CGFloat = 0
        
        let imgBackground = UIImageView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        imgBackground.image = UIImage(named: "register")
        imgBackground.userInteractionEnabled = true
        imgBackground.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imgBackground)
        
        
        // creating the base line
        width = self.view.frame.width - 60
        height = 1.5
        xAxis = self.view.frame.width/2 - width/2
        yAxis = self.view.frame.height/3 + 20
        
        let lineBaseForEmail = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lineBaseForEmail.backgroundColor = UIColor.init(colorLiteralRed: 57/255.0, green: 179/255.0, blue: 164/255.0, alpha: 1.0)
        self.view.addSubview(lineBaseForEmail)
        
        //Creating text field
        yAxis = lineBaseForEmail.frame.origin.y-30;
        width = lineBaseForEmail.frame.size.width-20;
        height = 30
        xAxis = self.view.frame.width/2-width/2
        
        textFieldUserName.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        textFieldUserName.backgroundColor = UIColor.clearColor()
        textFieldUserName.textColor = UIColor.whiteColor()
        textFieldUserName.tag = 1
        textFieldUserName.delegate = self
        textFieldUserName.borderStyle = UITextBorderStyle.None
        textFieldUserName.placeholder = "Email"
        textFieldUserName.setValue(UIColor.init(colorLiteralRed: 57/255.0, green: 179/255.0, blue: 164/255.0, alpha: 0.8), forKeyPath: "_placeholderLabel.textColor")
        textFieldUserName.autocorrectionType = UITextAutocorrectionType.No
        textFieldUserName.keyboardType = UIKeyboardType.EmailAddress
        textFieldUserName.autocapitalizationType = UITextAutocapitalizationType.None
        textFieldUserName.returnKeyType = UIReturnKeyType.Next
        textFieldUserName.clearButtonMode = UITextFieldViewMode.WhileEditing
        textFieldUserName.font = UIFont.systemFontOfSize(14.0)
        textFieldUserName.tintColor = UIColor.whiteColor()
        self.view.addSubview(textFieldUserName)
        
        
        //Creating validation label
        width = self.view.frame.width
        height = 25
        xAxis = self.view.frame.width/2-width/2
        yAxis = textFieldUserName.frame.origin.y-(height+20)
        
        lblValidation = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblValidation.text = ""
        lblValidation.textColor = UIColor.whiteColor()
        lblValidation.textAlignment = NSTextAlignment.Center
        lblValidation.font = UIFont.systemFontOfSize(13.0)
        self.view.addSubview(lblValidation)
        
        //Creating textField password
        yAxis = lineBaseForEmail.frame.origin.y+lineBaseForEmail.frame.size.height+20;
        width = lineBaseForEmail.frame.size.width-20;
        height = 30
        xAxis = self.view.frame.width/2-width/2
        
        textFieldPassword.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        textFieldPassword.backgroundColor = UIColor.clearColor()
        textFieldPassword.textColor = UIColor.whiteColor()
        textFieldPassword.tag = 2
        textFieldPassword.delegate = self
        textFieldPassword.borderStyle = UITextBorderStyle.None
        textFieldPassword.placeholder = "Password"
        textFieldPassword.setValue(UIColor.init(colorLiteralRed: 57/255.0, green: 179/255.0, blue: 164/255.0, alpha: 0.8), forKeyPath: "_placeholderLabel.textColor")
        textFieldPassword.autocorrectionType = UITextAutocorrectionType.No
        textFieldPassword.keyboardType = UIKeyboardType.Default
        textFieldPassword.autocapitalizationType = UITextAutocapitalizationType.None
        textFieldPassword.returnKeyType = UIReturnKeyType.Go
        textFieldPassword.clearButtonMode = UITextFieldViewMode.WhileEditing
        textFieldPassword.font = UIFont.systemFontOfSize(14.0)
        textFieldPassword.tintColor = UIColor.whiteColor()
        textFieldPassword.secureTextEntry = true
        self.view.addSubview(textFieldPassword)
        
        //Creating base line for password
        width = self.view.frame.width-60
        height = 1.5
        xAxis = self.view.frame.width/2-width/2
        yAxis = textFieldPassword.frame.origin.y+textFieldPassword.frame.size.height
        
        let lineBaseForPassword = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lineBaseForPassword.backgroundColor = UIColor.init(colorLiteralRed: 57/255.0, green: 179/255.0, blue: 164/255.0, alpha: 1.0)//57 179 164
        self.view.addSubview(lineBaseForPassword)
        
        //Creating login button
        width = lineBaseForPassword.frame.width-60
        height = 40
        xAxis = self.view.frame.width/2-width/2
        yAxis = lineBaseForPassword.frame.origin.y+lineBaseForPassword.frame.size.height+20
        
        let btnLogin = UIButton(type: UIButtonType.Custom) as UIButton
        btnLogin.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        btnLogin.addTarget(self, action: #selector(SignUpViewController.registerEvent(_:)), forControlEvents:.TouchUpInside)
        btnLogin.backgroundColor = UIColor.init(colorLiteralRed: 102/255.0, green: 158/255.0, blue: 93/255.0, alpha: 1.0)//102 158 93
        btnLogin.setTitle("Register", forState: UIControlState())
        btnLogin.setTitleColor(UIColor.whiteColor(), forState: UIControlState())
        btnLogin.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        btnLogin.layer.cornerRadius = 5.0
        self.view.addSubview(btnLogin)
        
        
        //Back arrow image
        width = 25
        height = 25
        xAxis =  10
        yAxis = 30
        
        let imgArrow = UIImageView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        imgArrow.image = UIImage(named: "Arrow_left")
        imgArrow.userInteractionEnabled = true
        self.view.addSubview(imgArrow)
        
        
        //Registration title
        width = self.view.frame.size.width-150
        height = 25
        xAxis =  self.view.frame.size.width/2-width/2
        yAxis = 30
        
        let registrationTitle = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        registrationTitle.text = "Registration"
        registrationTitle.textColor = UIColor.whiteColor()
        registrationTitle.textAlignment = NSTextAlignment.Center
        registrationTitle.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        self.view.addSubview(registrationTitle)
        
        
        //Creating Back button
        width = 60
        height = 40
        xAxis =  10
        yAxis = 20
        
        let btnBack = UIButton(type: UIButtonType.Custom) as UIButton
        btnBack.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        btnBack.addTarget(self, action: #selector(SignUpViewController.popViewController(_:)), forControlEvents:.TouchUpInside)
        btnBack.backgroundColor = UIColor.clearColor()
        btnBack.setTitleColor(UIColor.init(colorLiteralRed: 57/255, green: 179/255, blue: 164/255, alpha: 1.0), forState: UIControlState())
        self.view.addSubview(btnBack)
        
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
        
        let viewMenu = UIView(frame: CGRect(x: 0,y: 0,width: 64,height: 36))
        viewMenu.backgroundColor = UIColor.clearColor()
        
//        let imgViewMenu = UIImageView(frame: CGRectMake(viewMenu.frame.size.width/2-25/2,0,20,20))
//        imgViewMenu.image = UIImage(named: "profile_icon")
//        viewMenu.addSubview(imgViewMenu)
        
        let lblMenu = UILabel(frame: CGRect(x: 0,y: 20,width: viewMenu.frame.size.width,height: 24))
        lblMenu.text = "Profile"
        lblMenu.font = UIFont.boldSystemFontOfSize( 14.0)
        lblMenu.textAlignment = NSTextAlignment.Center
        lblMenu.textColor = UIColor.whiteColor()
        viewMenu.addSubview(lblMenu)
        
        
        let viewMovies = UIView(frame: CGRect(x: 0,y: 0,width: 64,height: 36))
        viewMovies.backgroundColor = UIColor.clearColor()
        
//        let imgViewMovies = UIImageView(frame: CGRectMake(viewMovies.frame.size.width/2-25/2,0,20,20))
//        imgViewMovies.image = UIImage(named: "Movies_icon")
//        viewMovies.addSubview(imgViewMovies)
        
        let lblMovies = UILabel(frame: CGRect(x: 0,y: 20,width: viewMovies.frame.size.width,height: 24))
        lblMovies.text = "Movies"
        lblMovies.font = UIFont.boldSystemFontOfSize( 14.0)
        lblMovies.textAlignment = NSTextAlignment.Center
        lblMovies.textColor = UIColor.whiteColor()
        viewMovies.addSubview(lblMovies)
        
        
        let viewTheaters = UIView(frame: CGRect(x: 0,y: 0,width: 64,height: 36))
        viewTheaters.backgroundColor = UIColor.clearColor()
        let imgViewTheaters = UIImageView(frame: CGRect(x: viewMovies.frame.size.width/2-25/2,y: 0,width: 20,height: 20))
        imgViewTheaters.image = UIImage(named: "Theaters_icon")
        viewTheaters.addSubview(imgViewTheaters)
        
        let lblTheaters = UILabel(frame: CGRect(x: 0,y: 20,width: viewMovies.frame.size.width,height: 24))
        lblTheaters.text = "Theaters"
        lblTheaters.font = UIFont.boldSystemFontOfSize( 14.0)
        lblTheaters.textAlignment = NSTextAlignment.Center
        lblTheaters.textColor = UIColor.whiteColor()
        viewTheaters.addSubview(lblTheaters)
        
        
        let viewUpComing = UIView(frame: CGRect(x: 0,y: 0,width: 64,height: 36))
        viewUpComing.backgroundColor = UIColor.clearColor()
        
//        let imgUpComing = UIImageView(frame: CGRectMake(viewMovies.frame.size.width/2-25/2,0,20,20))
//        imgUpComing.image = UIImage(named: "Movies_icon")
//        viewUpComing.addSubview(imgUpComing)
        
        let lblUpComing = UILabel(frame: CGRect(x: 0,y: 20,width: viewMovies.frame.size.width,height: 24))
        lblUpComing.text = "Upcoming"
        lblUpComing.font = UIFont.boldSystemFontOfSize( 12.0)
        lblUpComing.textAlignment = NSTextAlignment.Center
        lblUpComing.textColor = UIColor.whiteColor()
        viewUpComing.addSubview(lblUpComing)
        
        let items = [viewMenu,viewMovies, viewTheaters, viewUpComing]
        
        let controllers = [menuViewController,ctr1, ctr2, ctr3]
        
        let controller = SLPagingViewSwift(items: items, controllers: controllers, showPageControl: false)
        controller.navigationSideItemsStyle = SLNavigationSideItemsStyle.SLNavigationSideItemsStyleDefault
        let greencolor = UIColor(red: 27/255, green: 207/255, blue: 240/255, alpha: 1.0)
        let whitecolor = UIColor.whiteColor()
//        controller.pagingViewMoving = ({ subviews in
//            let viewsOfPage:NSArray = subviews as NSArray
//            for imgView in viewsOfPage {
//                var c = whitecolor
//                let originX = Double((imgView as AnyObject).frame.origin.x)
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
        
        controller.navigationController?.navigationBarHidden = false
        controller.navigationItem.hidesBackButton = true
        controller.navigationController?.navigationItem.hidesBackButton = true
        controller.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        
        //        controller.didChangedPage2 = ({ currentIndex in
        //            print("Current Index: \(currentIndex)")
        //
        //            if currentIndex == 0{
        //                NSNotificationCenter.defaultCenter().postNotificationName("ScrolledToPageZero", object: nil)
        //            }
        //            if currentIndex == 1{
        //                NSNotificationCenter.defaultCenter().postNotificationName("ScrolledToPageOne", object: nil)
        //            }
        //            if currentIndex == 2{
        //                NSNotificationCenter.defaultCenter().postNotificationName("ScrolledToPageTwo", object: nil)
        //            }
        //        })
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
//    //MARK - Setting gradient
//    func gradient(percent: Double, topX: Double, bottomX: Double, initC: UIColor, goal: UIColor) -> UIColor{
//        let t = (percent - bottomX) / (topX - bottomX)
//        
//        let cgInit = initC.CGColor.components
//        let cgGoal = goal.cgColor.components
//        
//        let r = cgInit[0] + CGFloat(t) * (cgGoal[0] - cgInit[0])
//        let g = cgInit[1] + CGFloat(t) * (cgGoal[1] - cgInit[1])
//        let b = cgInit[2] + CGFloat(t) * (cgGoal[2] - cgInit[2])
//        
//        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
//    }
    
    func popViewController(sender : UIButton! ) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    //MARK: - Buttons event
    
    func registerEvent(sender: UIButton?) {
        print("Register event")
        
        let textFieldPasswordLength:Int = (textFieldPassword.text?.characters.count)!
        
        if (textFieldPasswordLength > 3){
            
            //On login event successful
            textFieldPassword.resignFirstResponder()
            textFieldUserName.resignFirstResponder()
            
            lblValidation.text = "Please wait"
            
            //Adding activity view to self.view
            if ARSLineProgress.shown { return }
            ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
                print("Showed with completion block")
            }
            self.view.userInteractionEnabled = false
            
            callSignUpServices(textFieldUserName.text!, password: textFieldPassword.text!)
        }
        else
        {
            print("Show password validation error")
            
            textFieldPassword.becomeFirstResponder()
            
            let arrayUIElementsToShake = NSMutableArray()
            arrayUIElementsToShake.addObject(textFieldPassword)
            
            let afShaker = AFViewShaker(viewsArray: arrayUIElementsToShake as [AnyObject])
            afShaker?.shake()
            
            lblValidation.text = "Invalid password"
        }
        
        
        
        if isValidEmail(textFieldUserName.text!) {
            
            print("Proceed Register event")
            
            //On login event successful
            textFieldPassword.resignFirstResponder()
            textFieldUserName.resignFirstResponder()
            
            lblValidation.text = ""
        }
        else
        {
            print("Showing validation error")
            
            textFieldUserName.becomeFirstResponder()
            
            let arrayUIElementsToShake = NSMutableArray()
            arrayUIElementsToShake.addObject(textFieldUserName)
            
            
            let afShaker = AFViewShaker(viewsArray: arrayUIElementsToShake as [AnyObject])
            afShaker?.shake()
            
            lblValidation.text = "Invalid email"
            
        }
    }
    
    //MARK: - Username/Password cache method
    func saveUserNameAndPasswordToDefaults() {
        if let username = textFieldUserName.text {
            if let password = textFieldPassword.text {
                UserDefaultsStore.saveUserName(username, password: password)
            }
        }
    }
    
    //MARK: - Text field delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.tag == 1{
            print("Go to password text Field")
            textFieldPassword.becomeFirstResponder()
        }
        else{
            print("Perform register event")
            
            registerEvent(nil)
            
            textFieldPassword.resignFirstResponder()
        }
        
        return true
    }
    
    //MARK: - Email validation
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr) //(with: testStr)
    }
    
    //MARK: - Services part
    func callSignUpServices(email: String, password: String) {
        print("Making singUp API call")
        
        let url_ = NSURL(string: "http://citymoviesapi.bananaapps.co.in/api/User/Register")
        
        let request = NSMutableURLRequest(URL: url_!)
        request.HTTPMethod = "POST"
        
        let json = [ "User_Type":"3" , "Email": email,"Password":password]
        
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
                
                print("Got the Signup response with code: \(statusCode)")
                
                if (statusCode == 200) {
                    
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                            // process "json" as a dictionary
                            print("\(json)")
                            
                            let alert = UIAlertController(title: "Success", message: "An activation link sent to your mail id. Please activate the account to login", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                            
                            
                            self.navigationController!.popViewControllerAnimated(true)
                            
                            
                            
                            //We must also save username and password when user logs in for the first time
                            //                        self.saveUserNameAndPasswordToDefaults()
                            //
                            //                        print("Saved Username: ",UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kUserNameKey)!)
                            //                        print("Saved Password: ",UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kPasswordKey)!)
                            //
                            //                        dispatch_async(dispatch_get_main_queue()) {
                            //                            //self.performSegueWithIdentifier("LoginToMain", sender: nil)
                            //                            //                            self.launchMainScreen()
                            //                            //                            self.navigationController?.popViewControllerAnimated(false)
                            //
                            //                            for i in 0...10 {
                            //
                            //                                if(self.navigationController?.viewControllers[i].isKindOfClass(LaunchViewController)) == true{
                            //                                    self.navigationController?.popToViewController(self.navigationController?.viewControllers[i] as! LaunchViewController, animated: false)
                            //                                    break;
                            //                                }
                            //                            }
                            //                        }
                            
                        } else if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
                            // process "json" as an array
                            //                        print("\(json)")
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                
                                //We must also save username and password when user logs in for the first time
                                self.saveUserNameAndPasswordToDefaults()
                                
                                print("Saved Username: ",UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kUserNameKey)!)
                                print("Saved Password: ",UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kPasswordKey)!)
                                
                                //self.performSegueWithIdentifier("LoginToMain", sender: nil)
                                //                            self.launchMainScreen()
                                //                            self.navigationController?.popViewControllerAnimated(false)
                                
                                for i in 0...10 {
                                    if(self.navigationController?.viewControllers[i].isKindOfClass(LaunchViewController)) == true{
                                        self.navigationController?.popToViewController(self.navigationController?.viewControllers[i] as! LaunchViewController, animated: false)
                                        break;
                                    }
                                }
                                
                            }
                            
                        } else {
                            
                            //                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8)
                            //                        print("Error could not parse movies JSON string: \(jsonStr)")
                            
                            print("Error could not parse signup JSON string:")
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                
                                //We must also save username and password when user logs in for the first time
                                self.saveUserNameAndPasswordToDefaults()
                                
                                print("Saved Username: ",UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kUserNameKey)!)
                                print("Saved Password: ",UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kPasswordKey)!)
                                
                                //self.performSegueWithIdentifier("LoginToMain", sender: nil)
                                //                            self.launchMainScreen()
                                //                            self.navigationController?.popViewControllerAnimated(false)
                                
                                for i in 0...10 {
                                    if(self.navigationController?.viewControllers[i].isKindOfClass( LaunchViewController.self) == true) {
                                        self.navigationController?.popToViewController(self.navigationController?.viewControllers[i] as! LaunchViewController, animated: false)
                                        break;
                                    }
                                }
                                
                            }
                            
                        }
                        
                    } catch {
                        print("error serializing sigunup JSON: \(error)")
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            //We must also save username and password when user logs in for the first time
                            self.saveUserNameAndPasswordToDefaults()
                            
                            print("Saved Username: ",UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kUserNameKey)!)
                            print("Saved Password: ",UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kPasswordKey)!)
                            
                            //self.performSegueWithIdentifier("LoginToMain", sender: nil)
                            //                        self.launchMainScreen()
                            
                            for i in 0...10 {
                                if(self.navigationController?.viewControllers[i].isKindOfClass( LaunchViewController.self) == true) {
                                    self.navigationController?.popToViewController(self.navigationController?.viewControllers[i] as! LaunchViewController, animated: false)
                                    break;
                                }
                            }
                            //                        self.navigationController?.popViewControllerAnimated(false)
                            
                        }
                        
                        
                    }
                }
                else
                {
                    let arrayUIElementsToShake = NSMutableArray()
                    arrayUIElementsToShake.addObject(self.textFieldPassword)
                    arrayUIElementsToShake.addObject(self.textFieldUserName)
                    
                    print("Signup failed")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        let afShaker = AFViewShaker(viewsArray: arrayUIElementsToShake as [AnyObject])
                        afShaker.shake()
                        
                        self.lblValidation.text = "Email already registered"
                    }
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.view.userInteractionEnabled = true
                    ARSLineProgress.hideWithCompletionBlock({ () -> Void in
                        print("Hidden with completion block")
                    })
                }
                
            }
            

        });
        
        // do whatever you need with the task e.g. run
        task.resume()
        
        
        
        
    }
    
    //MARK: - Touches event
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textFieldPassword.resignFirstResponder()
        textFieldUserName.resignFirstResponder()
    }
    
    
}
