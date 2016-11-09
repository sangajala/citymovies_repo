//
//  FeedBackViewController.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 31/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit

class FeedBackViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    
    var movie : NSDictionary!
    var navigCRefFeedback : UINavigationController?
    var controlRefFeedback : SLPagingViewSwift?
    
    
    var textFieldUserName = UITextField()
    var textFieldphonnum = UITextField()
    var commenttextView = UITextView()
    
    
    init ( justInit : NSDictionary ) {
        
        self.movie = justInit
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.greenColor()
        
        navigCRefFeedback?.navigationBarHidden = true
        
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
        btnBack.setImage(UIImage(named: "Arrow_left"), forState: UIControlState())
        btnBack.tintColor = UIColor.whiteColor()
        btnBack.addTarget(self, action: #selector(FeedBackViewController.dismissVC), forControlEvents: .TouchUpInside)
        navigView.addSubview(btnBack)
        navigView.backgroundColor = UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
        view.addSubview(navigView)
        
        width = navigView.frame.size.width-(btnBack.frame.size.width*2+50)
        xAxis = navigView.frame.size.width/2-width/2
        yAxis = btnBack.frame.origin.y
        height = 30
        
        let lblMovieDetails = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        lblMovieDetails.backgroundColor = UIColor.clearColor()
        lblMovieDetails.text = "Feedback"
        lblMovieDetails.font = UIFont(name: "Helvetica Neue", size: 18)
        lblMovieDetails.textColor = UIColor.whiteColor()
        lblMovieDetails.textAlignment = NSTextAlignment.Center
        navigView.addSubview(lblMovieDetails)
        
        
        
        
        
        
        
        //Creating based line
        width = self.view.frame.width-60
        height = 1.5
        xAxis = self.view.frame.width/2-width/2
        yAxis = self.view.frame.height/3-20//50 is the height of TextField + 20 is for titleLabel on top of it
        
        let lineBaseForUsernam = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lineBaseForUsernam.backgroundColor = UIColor.init(colorLiteralRed: 57/255.0, green: 179/255.0, blue: 164/255.0, alpha: 1.0)//57 179 164
        self.view.addSubview(lineBaseForUsernam)
        
        
        
        
        
        //Creating text field
        yAxis = lineBaseForUsernam.frame.origin.y-30;
        width = lineBaseForUsernam.frame.size.width-20;
        height = 30
        xAxis = self.view.frame.width/2-width/2
        
        textFieldUserName.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        textFieldUserName.backgroundColor = UIColor.clearColor()
        textFieldUserName.textColor = UIColor.whiteColor()
        textFieldUserName.tag = 1
        textFieldUserName.delegate = self
        textFieldUserName.borderStyle = UITextBorderStyle.None
        textFieldUserName.placeholder = "Name"
        textFieldUserName.textAlignment = .Left
        textFieldUserName.attributedPlaceholder = NSAttributedString(string:"Name",
                                                                     attributes:[NSForegroundColorAttributeName: UIColor.init(white: 1, alpha: 0.5)])
        //textFieldUserName.setValue(UIColor.init(colorLiteralRed: 57/255.0, green: 179/255.0, blue: 164/255.0, alpha: 0.8), forKeyPath: "_placeholderLabel.textColor")
        textFieldUserName.autocorrectionType = UITextAutocorrectionType.No
        textFieldUserName.keyboardType = UIKeyboardType.Alphabet
        textFieldUserName.autocapitalizationType = UITextAutocapitalizationType.None
        textFieldUserName.returnKeyType = UIReturnKeyType.Next
        textFieldUserName.clearButtonMode = UITextFieldViewMode.WhileEditing
        textFieldUserName.font = UIFont.systemFontOfSize(14.0)
        textFieldUserName.tintColor = UIColor.whiteColor()
        self.view.addSubview(textFieldUserName)
        
        
        
        
        
        
        
        
        
        //Creating textField phonnumber
        
        yAxis = lineBaseForUsernam.frame.origin.y+lineBaseForUsernam.frame.size.height+20;
        width = lineBaseForUsernam.frame.size.width-20;
        height = 30
        xAxis = textFieldUserName.frame.origin.x
        
        textFieldphonnum.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        textFieldphonnum.backgroundColor = UIColor.clearColor()
        textFieldphonnum.textColor = UIColor.whiteColor()
        textFieldphonnum.tag = 2
        textFieldphonnum.delegate = self
        textFieldphonnum.borderStyle = UITextBorderStyle.None
        textFieldphonnum.placeholder = "Mobile Number"
        textFieldphonnum.textAlignment = .Left
        
        // textFieldPassword.setValue(UIColor.init(colorLiteralRed: 57/255.0, green: 179/255.0, blue: 164/255.0, alpha: 0.8), forKeyPath: "_placeholderLabel.textColor")
        
        textFieldphonnum.attributedPlaceholder = NSAttributedString(string:"Mobile Number",
                                                                    attributes:[NSForegroundColorAttributeName: UIColor.init(white: 1, alpha: 0.5)])
        
        
        textFieldphonnum.autocorrectionType = UITextAutocorrectionType.No
        textFieldphonnum.keyboardType = UIKeyboardType.PhonePad
        textFieldphonnum.autocapitalizationType = UITextAutocapitalizationType.None
        textFieldphonnum.returnKeyType = UIReturnKeyType.Go
        textFieldphonnum.clearButtonMode = UITextFieldViewMode.WhileEditing
        textFieldphonnum.font = UIFont.systemFontOfSize(14.0)
        textFieldphonnum.tintColor = UIColor.whiteColor()
        textFieldphonnum.secureTextEntry = false
        self.view.addSubview(textFieldphonnum)
        
        
        //Creating base line for phonenum 2nd line
        width = self.view.frame.width-60
        height = 1.5
        xAxis = self.view.frame.width/2-width/2
        yAxis = textFieldphonnum.frame.origin.y+textFieldphonnum.frame.size.height
        
        let lineBaseForphonnum = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lineBaseForphonnum.backgroundColor = UIColor.init(colorLiteralRed: 57/255.0, green: 179/255.0, blue: 164/255.0, alpha: 1.0)//57 179 164
        self.view.addSubview(lineBaseForphonnum)
        
        
        
        
        //Creating base line for  3rdline
        
        width = self.view.frame.width-60
        height = 1.5
        xAxis = self.view.frame.width/2-width/2
        yAxis = textFieldphonnum.frame.origin.y+textFieldphonnum.frame.size.height + 50
        
        let lineBaseForthirdline = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lineBaseForthirdline.backgroundColor = UIColor.init(colorLiteralRed: 57/255.0, green: 179/255.0, blue: 164/255.0, alpha: 1.0)//57 179 164
        self.view.addSubview(lineBaseForthirdline)
        
        
        
        
        
        //stright leftlineview
        
        
        
        width = 1.5//self.view.frame.width-200
        height = 150
        xAxis = 26//self.view.frame.width/2-width/2
        yAxis = lineBaseForthirdline.frame.origin.y+lineBaseForthirdline.frame.size.height + 5
        
        let leftline = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        leftline.backgroundColor = UIColor.init(colorLiteralRed: 57/255.0, green: 179/255.0, blue: 164/255.0, alpha: 1.0)//57 179 164
        self.view.addSubview(leftline)
        
        //stright rightlineview2
        
        
        
        width = 1.5//self.view.frame.width-200
        height = 150
        xAxis = self.view.frame.width - 28
        yAxis = lineBaseForthirdline.frame.origin.y+lineBaseForthirdline.frame.size.height + 5
        
        let rightline = UIView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        rightline.backgroundColor = UIColor.init(colorLiteralRed: 57/255.0, green: 179/255.0, blue: 164/255.0, alpha: 1.0)//57 179 164
        self.view.addSubview(rightline)
        
        
        
        
        //textview
        
        
        width = self.view.frame.width-60
        height = 120
        xAxis = self.view.frame.width/2-width/2
        yAxis = lineBaseForthirdline.frame.origin.y+lineBaseForthirdline.frame.size.height + 10
        
        commenttextView.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        commenttextView.delegate = self
        commenttextView.textAlignment = NSTextAlignment.Left
        commenttextView.text = ""
        commenttextView.textColor = UIColor.lightGrayColor()
        commenttextView.scrollEnabled = true
        
        commenttextView.textColor = UIColor.whiteColor()
        commenttextView.backgroundColor = UIColor.clearColor()
        commenttextView.returnKeyType = UIReturnKeyType.Done
        commenttextView.resignFirstResponder()
        self.view.addSubview(commenttextView)
        
        
        
        
        //send button
        
        
        width = commenttextView.frame.width
        height = 30
        xAxis = self.view.frame.width/2-width/2 - 2
        yAxis = commenttextView.frame.origin.y+commenttextView.frame.size.height+30
        
        let btnSend = UIButton(type: UIButtonType.Custom) as UIButton
        btnSend.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        btnSend.addTarget(self, action: #selector(FeedBackViewController.sendEvent(_:)), forControlEvents:.TouchUpInside)
        btnSend.backgroundColor = UIColor.init(colorLiteralRed: 102/255.0, green: 158/255.0, blue: 93/255.0, alpha: 1.0)//102 158 93
        btnSend.setTitle("Send", forState: UIControlState())
        btnSend.setTitleColor(UIColor.whiteColor(), forState: UIControlState())
        btnSend.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        //        btnSend.layer.cornerRadius = 5.0
        self.view.addSubview(btnSend)
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        /*  UIView.animateWithDuration(0.2, delay: 0.0, options: [.Repeat, .CurveEaseInOut], animations: {
         self.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -10);
         
         }
         , completion: nil)*/
        
        self.view.frame.origin.y -= 120
        
        
        return true
    }
    
    
    func textViewDidEndEditing(textView: UITextView) {
        
        self.view.frame.origin.y += 120
        
        textView.resignFirstResponder()
        
    }
    
    
    func textView(textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            
            textView.resignFirstResponder()
            return true
            
        }
        return true
    }
    
    
    //back arrow button
    
    
    func btnTouched(sender: UIButton) {
        print("button clicked")
    }
    
    
    
    //send button event
    
    func sendEvent(sender: UIButton?) {
        print("Button clicked")
        
    }
    
    func dismissVC () {
        navigCRefFeedback?.navigationBar.hidden = false
        navigCRefFeedback?.navigationBarHidden = false
        navigCRefFeedback!.popToViewController(controlRefFeedback!, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Touches method
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textFieldphonnum.resignFirstResponder()
        textFieldUserName.resignFirstResponder()
        commenttextView.resignFirstResponder()
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
