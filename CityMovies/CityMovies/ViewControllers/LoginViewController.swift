//
//  LoginViewController.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 03/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    var navigRefe : UINavigationController?
    var controlRefe_launchVC : LaunchViewController?
    
    var textFieldUserName = UITextField()
    var textFieldPassword = UITextField()
    var lblValidation = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.blackColor()
        
        self.navigationController?.navigationBarHidden = true
        
        //Adding background image
        var width:CGFloat = self.view.frame.width
        var height:CGFloat = self.view.frame.height
        var xAxis:CGFloat = 0
        var yAxis:CGFloat = 0
        
        let imgBackground = UIImageView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        imgBackground.image = UIImage(named: "loginBackground")
        imgBackground.userInteractionEnabled = true
        imgBackground.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imgBackground)
        
        
        //Designing starts here
        //Creating based line
        width = self.view.frame.width-60
        height = 1.5
        xAxis = self.view.frame.width/2-width/2
        yAxis = self.view.frame.height/3-20//50 is the height of TextField + 20 is for titleLabel on top of it
        
        let lineBaseForEmail = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lineBaseForEmail.backgroundColor = UIColor.init(colorLiteralRed: 57/255.0, green: 179/255.0, blue: 164/255.0, alpha: 1.0)//57 179 164
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
        width = lineBaseForEmail.frame.size.width-70;
        height = 30
        xAxis = textFieldUserName.frame.origin.x
        
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
        
        //Creating Lost it button
        width = lineBaseForPassword.frame.size.width-textFieldPassword.frame.size.width
        height = textFieldPassword.frame.size.height
        xAxis = textFieldPassword.frame.origin.x+textFieldPassword.frame.size.width
        yAxis = textFieldPassword.frame.origin.y
        
        let btnLostIt = UIButton(type: UIButtonType.Custom) as UIButton
        btnLostIt.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        btnLostIt.addTarget(self, action: #selector(LoginViewController.lostItEvent(_:)), forControlEvents:.TouchUpInside)
        btnLostIt.backgroundColor = UIColor.clearColor()
        btnLostIt.setTitle("Lost It ?", forState: UIControlState())
        btnLostIt.setTitleColor(UIColor.whiteColor(), forState: UIControlState())
        btnLostIt.titleLabel?.font = UIFont.boldSystemFontOfSize( 13.0)
        btnLostIt.layer.cornerRadius = 5.0
        self.view.addSubview(btnLostIt)
        
        
        //Creating login button
        width = lineBaseForPassword.frame.width-60
        height = 40
        xAxis = self.view.frame.width/2-width/2
        yAxis = lineBaseForPassword.frame.origin.y+lineBaseForPassword.frame.size.height+20
        
        let btnLogin = UIButton(type: UIButtonType.Custom) as UIButton
        btnLogin.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        btnLogin.addTarget(self, action: #selector(LoginViewController.loginEvent(_:)), forControlEvents:.TouchUpInside)
        btnLogin.backgroundColor = UIColor.init(colorLiteralRed: 102/255.0, green: 158/255.0, blue: 93/255.0, alpha: 1.0)//102 158 93
        btnLogin.setTitle("Sign In", forState: UIControlState())
        btnLogin.setTitleColor(UIColor.whiteColor(), forState: UIControlState())
        btnLogin.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        btnLogin.layer.cornerRadius = 5.0
        self.view.addSubview(btnLogin)
        
        
        //Creating SignUp button
        width = lineBaseForPassword.frame.width-60
        height = 40
        xAxis = self.view.frame.width/2-width/2
        yAxis = btnLogin.frame.origin.y+btnLogin.frame.size.height+10
        
        let btnSignUp = UIButton(type: UIButtonType.Custom) as UIButton
        btnSignUp.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        btnSignUp.addTarget(self, action: #selector(LoginViewController.signUpEvent(_:)), forControlEvents:.TouchUpInside)
        btnSignUp.backgroundColor = UIColor.clearColor()
        btnSignUp.setTitle("Sign Up", forState: UIControlState())
        btnSignUp.setTitleColor(UIColor.orangeColor(), forState: UIControlState())
        btnSignUp.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        btnSignUp.layer.cornerRadius = 5.0
        self.view.addSubview(btnSignUp)
        
        //Login title
        width = self.view.frame.size.width-150
        height = 35
        xAxis =  self.view.frame.size.width/2-width/2
        yAxis = 60
        
        let loginTitle = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        loginTitle.text = "Sign In"
        loginTitle.textColor = UIColor.whiteColor()
        loginTitle.textAlignment = NSTextAlignment.Center
        loginTitle.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        self.view.addSubview(loginTitle)
        
        
        
        //Creaitng Facebook button
        
        width = lineBaseForPassword.frame.width-30
        height = width/6.06
        xAxis = self.view.frame.width/2-width/2
        yAxis = btnSignUp.frame.origin.y+btnSignUp.frame.size.height+10
        
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        loginView.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
        self.view.addSubview(loginView)
        
        
        //Button skip
        width = 50
        height = 30
        xAxis = self.view.frame.width-(width+10)
        yAxis = self.view.frame.size.height-(height+10)
        
        let btnSkip = UIButton(type: UIButtonType.Custom) as UIButton
        btnSkip.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        btnSkip.addTarget(self, action: #selector(LoginViewController.skipEvent(_:)), forControlEvents:.TouchUpInside)
        btnSkip.backgroundColor = UIColor.clearColor()
        btnSkip.setTitle("Skip", forState: UIControlState())
        btnSkip.setTitleColor(UIColor.whiteColor(), forState: UIControlState())
        btnSkip.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        btnSkip.layer.cornerRadius = 5.0
        self.view.addSubview(btnSkip)
        
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
        lblMenu.font = UIFont.boldSystemFontOfSize( 12.0)
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
        lblMovies.font = UIFont.boldSystemFontOfSize( 12.0)
        lblMovies.textAlignment = NSTextAlignment.Center
        lblMovies.textColor = UIColor.whiteColor()
        viewMovies.addSubview(lblMovies)
        
        
        let viewTheaters = UIView(frame: CGRect(x: 0,y: 0,width: 64,height: 36))
        viewTheaters.backgroundColor = UIColor.clearColor()
        
//        let imgViewTheaters = UIImageView(frame: CGRectMake(viewMovies.frame.size.width/2-25/2,0,20,20))
//        imgViewTheaters.image = UIImage(named: "Theaters_icon")
//        viewTheaters.addSubview(imgViewTheaters)
        
        let lblTheaters = UILabel(frame: CGRect(x: 0,y: 20,width: viewMovies.frame.size.width,height: 24))
        lblTheaters.text = "Theaters"
        lblTheaters.font = UIFont.boldSystemFontOfSize( 12.0)
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
//            let viewsOfPage:NSArray = subviews
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
        
        menuViewController.navigRefe = self.navigationController
        menuViewController.controlRefe = controller
        
        ctr1.navigRef = self.navigationController
        ctr1.controlRef = controller
        
        ctr2.navigRef = self.navigationController
        ctr2.controlRef = controller
        
        ctr3.navigRef = self.navigationController
        ctr3.controlRef = controller
        
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
    
    //MARK: - Button Skip
    func skipEvent(sender: UIButton?) {
        print("Skip event");
        
        UserDefaultsStore.userDefaults.setValue("true", forKey: UserDefaultsKeys.kSkipEvent)
        
        dispatch_async(dispatch_get_main_queue()) {
            self.navigationController?.popViewControllerAnimated(false)
        }
    }
    
    //MARK: - Buttons event
    func loginEvent(sender: UIButton?) {
        print("Login event")
        
        
        let textFieldPasswordLength:Int = (textFieldPassword.text?.characters.count)!
        
        if isValidEmail(textFieldUserName.text!) {
            
            lblValidation.text = ""
            
            if (textFieldPasswordLength > 3){
                
                print("Proceed login event")
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
                
                callLoginServices(textFieldUserName.text!, password: textFieldPassword.text!)
                
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
    
    //MARK: - SignUp event
    func signUpEvent(sender: UIButton?) {
        print("Sign up event")
        
        //On login event successful
        textFieldPassword.resignFirstResponder()
        textFieldUserName.resignFirstResponder()
        
        self.performSegueWithIdentifier("LoginToSignUp", sender: nil)
    }
    
    //MARK - Facebook button event
    func facebookLoginEvent(sender: UIButton) {
        print("Facebook login tapped")
        
        
    }
    
    //MARK: - FBLogin delegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("FBLogin result: \(result)")

        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
                returnUserData()
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("FBLogin logout")
        
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func returnUserData()
    {
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if ((error) != nil){
                    // Process error
                    print("Error: \(error)")
                }
                else
                {
                    if result.valueForKey( "email") != nil
                    {
                        print("fetched user: \(result)")
                        let userName : NSString = result.valueForKey( "name") as! NSString
                        print("User Name is: \(userName)")
                        let userEmail : NSString = result.valueForKey( "email") as! NSString
                        print("User Email is: \(userEmail)")
                        let userID : NSString = result.valueForKey( "id") as! NSString
                        print("User Email is: \(userID)")
                        
                        let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                        print("\(accessToken)")
                        
                        //Saving FB credintials to the user defaults
                        UserDefaultsStore.saveUserName(userEmail as String, password: accessToken)
                        self.navigationController?.popViewControllerAnimated(true)
                        
                        //Adding activity view to self.view
//                        if ARSLineProgress.shown { return }
//                        ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
//                            print("Showed with completion block")
//                        }
//                        self.view.userInteractionEnabled = false
                        
//                        self.callSignUpServices(userEmail as String, password: accessToken as String)
                    }
                    else{
                        
                        let alert = UIAlertController(title: "Email not found", message: "Email must be granted to proceed login through Facebook", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
                        alert.addAction(UIAlertAction(title: "Grant now", style: .Default, handler: { action in
                            switch action.style{
                            case .Default:
                                print("Reask for login with email")
                                
                                let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
                                
                                fbLoginManager.logInWithPublishPermissions(["email"], fromViewController:self, handler: { (result, error) -> Void in
                                    if (error == nil)
                                    {
                                        let fbloginresult : FBSDKLoginManagerLoginResult = result!
                                        
                                        if(fbloginresult.isCancelled) {
                                            //Show Cancel alert
                                        } else if(fbloginresult.grantedPermissions.contains("email")) {
                                            self.returnUserData()
                                        }
                                        
                                    }
                                })
                                
                            case .Cancel:
                                print("cancel")
                                
                            case .Destructive:
                                print("destructive")
                            }
                        }))
                        
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            })
        }
        
        
//        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
//        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
//            
//            if ((error) != nil)
//            {
//                // Process error
//                print("Error: \(error)")
//            }
//            else
//            {
//                print("fetched user: \(result)")
//                let userName : NSString = result.valueForKey("name") as! NSString
//                print("User Name is: \(userName)")
//                let userEmail : NSString! = result.valueForKey("email") as! NSString
//                print("User Email is: \(userEmail)")
//                
//                var accessToken = FBSDKAccessToken.currentAccessToken().tokenString
//                print("\(accessToken)")
//                
//            }
//        })
    }
    
    
    
    //MARK: - Lost it event
    func lostItEvent(sender: UIButton) {
        print("Lost it event")
        
        //On login event successful
        textFieldPassword.resignFirstResponder()
        textFieldUserName.resignFirstResponder()
        
        let forgotPasswordViewController = ForgotPasswordViewController()
        self.navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
    
    //MARK: - Text field delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.tag == 1{
            print("Go to password text Field")
            textFieldPassword.becomeFirstResponder()
        }
        else{
            print("Perform login event")
            
            loginEvent(nil)
            
            //            textFieldPassword.resignFirstResponder()
        }
        
        return true
    }
    
    
    //MARK: - Username/Password cache method
    func saveUserNameAndPasswordToDefaults() {
        if let username = textFieldUserName.text {
            if let password = textFieldPassword.text {
                UserDefaultsStore.saveUserName(username, password: password)//UserDefaultsStore.saveUserName(username, password: password)
                
                //                var strUserName:String! = UserDefaultsStore.userDefaults.objectForKey(UserDefaultsKeys.kUserNameKey) as! String
                //                var strUserPassword:String! = UserDefaultsStore.userDefaults.objectForKey(UserDefaultsKeys.kPasswordKey) as! String
                
                print("Username: \(UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kUserNameKey))")
                print("Password: \(UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kPasswordKey))")
                
                print("");
            }
        }
    }
    
    //MARK: - Email validation
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    //MARK: - Touches event
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textFieldPassword.resignFirstResponder()
        textFieldUserName.resignFirstResponder()
    }
    
    //MARK: - Services part
    func callLoginServices(email: String, password: String) {
        print("Making login API call")
        
        let url_ = NSURL(string: "http://citymoviesapi.bananaapps.co.in/api/User/Login")
        
        let request = NSMutableURLRequest(URL: url_!)
        request.HTTPMethod = "POST"
        
        let json = ["Email": email,"Password":password]
        
        do {
            let jsonResult = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            request.HTTPBody = jsonResult
            print("dictionar \(jsonResult)")
        } catch let error as NSError {
            print("error in constructing dictionar: \(error.localizedDescription)")
        }
        
        
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        
        
        
        
//        let url_ = NSURL(string: "http://citymoviesapi.bananaapps.co.in/api/User/Login?Email=\(email)&Password=\(password)")
//        let request = NSMutableURLRequest(URL: url_!)
//        request.HTTPMethod = "GET"
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            // notice that I can omit the types of data, response and error
            // your code
            
            if response != nil{
                
                let httpResponse = response as! NSHTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                print("Got the login response with code: \(statusCode)")
                
                
                if (statusCode == 200) {
                    
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                            // process "json" as a dictionary
                            //                        print("\(json)")
                            
                            //We must also save username and password when user logs in for the first time
                            self.saveUserNameAndPasswordToDefaults()
                            
                            print("Saved Username: %@",UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kUserNameKey))
                            print("Saved Password: %@",UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kPasswordKey))
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                //self.performSegueWithIdentifier("LoginToMain", sender: nil)
                                //self.launchMainScreen()
                                
                                self.navigationController?.popViewControllerAnimated(true)
                            }
                            
                        } else if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
                            // process "json" as an array
                            //                        print("\(json)")
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                
                                //We must also save username and password when user logs in for the first time
                                self.saveUserNameAndPasswordToDefaults()
                                
                                print("Saved Username: %@",UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kUserNameKey))
                                print("Saved Password: %@",UserDefaultsStore.userDefaults.objectForKey( UserDefaultsKeys.kPasswordKey))
                                
                                //self.performSegueWithIdentifier("LoginToMain", sender: nil)
                                //                            self.launchMainScreen()
                                
                                self.navigationController?.popViewControllerAnimated(true)
                                
                            }
                            
                        } else {
                            //                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8)
                            //                        print("Error could not parse movies JSON string: \(jsonStr)")
                            print("Error could not parse movies JSON string:")
                        }
                        
                    } catch {
                        print("error serializing movies JSON: \(error)")
                    }
                }
                else
                {
                    let arrayUIElementsToShake = NSMutableArray()
                    arrayUIElementsToShake.addObject(self.textFieldPassword)
                    arrayUIElementsToShake.addObject(self.textFieldUserName)
                    
                    print("Login failed")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        let afShaker = AFViewShaker(viewsArray: arrayUIElementsToShake as [AnyObject])
                        afShaker.shake()
                        
                        self.lblValidation.text = "Invalid Email or Password"
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
