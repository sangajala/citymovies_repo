//
//  ForgotPasswordViewController.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 04/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    var textFieldUserName = UITextField()
    var lblValidation = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.clearColor()
        
        var width : CGFloat = self.view.frame.width
        var height : CGFloat = self.view.frame.height
        var xAxis : CGFloat = 0
        var yAxis : CGFloat = 0
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "loginBackground")?.drawInRect(self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor.init(patternImage: image!)
        
        
        // navigationBar
        height = 64
        let navigView : UIView = UIView(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        
        height = 30
        width = 30
        xAxis = 10
        yAxis = 20 + ((navigView.frame.size.height-20)/2-height/2)
        
        let btnBack = UIButton(type: .Custom)
        btnBack.frame = CGRect(x: xAxis,y: yAxis,width: width,height: height)
        btnBack.userInteractionEnabled = true
        btnBack.setImage(UIImage(named: "Arrow_left"), forState: UIControlState())
        btnBack.tintColor = UIColor.whiteColor()
        btnBack.addTarget(self, action: #selector(ForgotPasswordViewController.popViewController(_:)), forControlEvents: .TouchUpInside)
        navigView.addSubview(btnBack)
        navigView.backgroundColor = UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
        view.addSubview(navigView)
        
        width = navigView.frame.size.width-(btnBack.frame.size.width*2+50)
        xAxis = navigView.frame.size.width/2-width/2
        yAxis = btnBack.frame.origin.y
        height = 30
        
        let lblMovieDetails = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        lblMovieDetails.backgroundColor = UIColor.clearColor()
        lblMovieDetails.text = "Forgot Password"
        lblMovieDetails.font = UIFont(name: "Helvetica Neue", size: 18)
        lblMovieDetails.textColor = UIColor.whiteColor()
        lblMovieDetails.textAlignment = NSTextAlignment.Center
        navigView.addSubview(lblMovieDetails)
        
        
        designEMailField()
        
    }
    
    //MAKR: - Design email field
    func designEMailField() {
        
        //Designing starts here
        //Creating based line
        var width : CGFloat = self.view.frame.width-60
        var height : CGFloat = 1.5
        var xAxis : CGFloat = self.view.frame.width/2-width/2
        var yAxis : CGFloat = self.view.frame.height/3-20//50 is the height of TextField + 20 is for titleLabel on top of it
        
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
        textFieldUserName.returnKeyType = UIReturnKeyType.Go
        textFieldUserName.clearButtonMode = UITextFieldViewMode.WhileEditing
        textFieldUserName.font = UIFont.systemFontOfSize( 14.0)
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
        
        //Creating login button
        width = lineBaseForEmail.frame.width-60
        height = 40
        xAxis = self.view.frame.width/2-width/2
        yAxis = lineBaseForEmail.frame.origin.y+lineBaseForEmail.frame.size.height+20
        
        let btnLogin = UIButton(type: UIButtonType.Custom) as UIButton
        btnLogin.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        btnLogin.addTarget(self, action: #selector(ForgotPasswordViewController.resetPasswordEvent), forControlEvents:.TouchUpInside)
        btnLogin.backgroundColor = UIColor.init(colorLiteralRed: 102/255.0, green: 158/255.0, blue: 93/255.0, alpha: 1.0)//102 158 93
        btnLogin.setTitle("Reset", forState: UIControlState())
        btnLogin.setTitleColor(UIColor.whiteColor(), forState: UIControlState())
        btnLogin.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        btnLogin.layer.cornerRadius = 5.0
        self.view.addSubview(btnLogin)
        
    }
    
    func resetPasswordEvent() {
        

        if isValidEmail(textFieldUserName.text!) {
            
            lblValidation.text = ""
            
            print("Proceed reset event")
            //On login event successful
            textFieldUserName.resignFirstResponder()
            
//            lblValidation.text = "Password reset link sent to email"
            
            sendForgotPasswordRequest()
            
//                //Adding activity view to self.view
//                if ARSLineProgress.shown { return }
//                ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
//                    print("Showed with completion block")
//                }
//                self.view.userInteractionEnabled = false
            
                //Perform user forgot password request
                
            
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
    
    //MARK: - Text field delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        resetPasswordEvent()
        
        return true
    }
    
    //MARK: - Email validation
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)// (with: testStr)
    }
    
    func popViewController(sender : UIButton ) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: - Services part
    func sendForgotPasswordRequest() {
        
        //Adding activity view to self.view
        if ARSLineProgress.shown { return }
            ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
        }
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.userInteractionEnabled = false
        
        print("Getting movies list")
        
        let userEmail = self.textFieldUserName.text
        
//        let url_resetPassword = NSURL(string:"http://citymoviesapi.bananaapps.co.in/api/User/Forgotpassword?Email=\(userEmail!)")
        let request = NSMutableURLRequest(URL: NSURL(string:"http://citymoviesapi.bananaapps.co.in/api/User/Forgotpassword?Email=\(userEmail!)")!)
        request.HTTPMethod = "GET"
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            
            if response != nil{
                
                let httpResponse = response as! NSHTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                print("Got the login response with code: \(statusCode)")
                
                
                
                if (statusCode == 200) {
                    
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                            // process "json" as a dictionary
                            print("\(json)")
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                self.lblValidation.text = "Password reset link sent to email"
                            }
                            
                        } else if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
                            // process "json" as an array
                            dispatch_async(dispatch_get_main_queue()) {
                                self.lblValidation.text = "Password reset link sent to email"
                            }
                            
                        } else {
                            //                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                            //                        print("Error could not parse movies JSON string: \(jsonStr)")
                            print("Error could not parse movies JSON string:")
                            dispatch_async(dispatch_get_main_queue()) {
                                self.lblValidation.text = "Something went wrong please try again"
                            }
                        }
                        
                    } catch {
                        print("error serializing movies JSON: \(error)")
                        dispatch_async(dispatch_get_main_queue()) {
                            self.lblValidation.text = "Something went wrong please try again"
                        }
                    }
                    
                }
                else{
                    dispatch_async(dispatch_get_main_queue()) {
                        self.lblValidation.text = "Invalid Email"
                    }
                }
                
                
                dispatch_async(dispatch_get_main_queue()) {
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.window?.userInteractionEnabled = true
                    ARSLineProgress.hideWithCompletionBlock({ () -> Void in
                        print("Hidden with completion block")
                    })
                }
                
            }
            
        });
        
        // do whatever you need with the task e.g. run
        task.resume()
            
            
            
            
            
            
            
//            // notice that I can omit the types of data, response and error
//            // your code
//            
//            let httpResponse = response as! NSHTTPURLResponse
//            let statusCode = httpResponse.statusCode
//            
//            if (statusCode == 200) {
//                
//                do {
//                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
//                        // process "json" as a dictionary
//                        print("\(json)")
//                        
//                        self.lblValidation.text = "Password reset link sent to email"
//                        
//                    } else if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
//                        // process "json" as an array
//                        
//                        self.lblValidation.text = "Password reset link sent to email"
//                        
//                    } else {
//                        //                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                        //                        print("Error could not parse movies JSON string: \(jsonStr)")
//                        print("Error could not parse movies JSON string:")
//                        
//                        self.lblValidation.text = "Something went wrong please try again"
//                    }
//                    
//                } catch {
//                    print("error serializing movies JSON: \(error)")
//                    self.lblValidation.text = "Something went wrong please try again"
//                }
//            }
//            else if (statusCode == 404){
//                
//                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
//                    // process "json" as a dictionary
//                    
//                    let dictItem = json as NSDictionary
//                    self.lblValidation.text = dictItem.valueForKey("Message") as String
//                    
//                    
//                    
//                } else if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
//                    // process "json" as an array
//                    
//                    
//                    
//                } else {
//                    //                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                    //                        print("Error could not parse movies JSON string: \(jsonStr)")
//                    print("Error could not parse movies JSON string:")
//                    
//                    self.lblValidation.text = "Something went wrong please try again"
//                }
//                
//            }
//
//            dispatch_async(dispatch_get_main_queue()) {
//                appDelegate.window?.userInteractionEnabled = true
//                //                self.view.userInteractionEnabled = true
//                ARSLineProgress.hideWithCompletionBlock({ () -> Void in
//                    print("Hidden with completion block")
//                })
//            }
//            
//        });
//        
//        // do whatever you need with the task e.g. run
//        task.resume()
        
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
