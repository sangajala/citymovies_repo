//
//  AboutUsViewController.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 31/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movie : NSDictionary!
    var navigCRefeAboutUS : UINavigationController?
    var controlCRefeAboutUS : SLPagingViewSwift?
    
    var tableViewAboutUS = UITableView()
    var arrayAboutUS = NSMutableArray()
    
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
        
        arrayAboutUS = NSMutableArray()
        arrayAboutUS.addObject("List of theaters around your local area with latest information about which movie is playing where.")
        arrayAboutUS.addObject("View Show-times for cinema.")
        arrayAboutUS.addObject("Links to book your tickets through the app.")
        arrayAboutUS.addObject("Write reviews about the movie and share them on Facebook.")
        arrayAboutUS.addObject("Watch trialers and movies online.")
        
        self.view.backgroundColor = UIColor.blackColor()
        
        navigCRefeAboutUS?.navigationBarHidden = true
        
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
        btnBack.addTarget(self, action: #selector(AboutUsViewController.dismissVC), forControlEvents: .TouchUpInside)
        navigView.addSubview(btnBack)
        navigView.backgroundColor = UIColor.init(colorLiteralRed: 39/255.0, green: 49/255.0, blue: 72/255.0, alpha: 1.0)
        view.addSubview(navigView)
        
        width = navigView.frame.size.width-(btnBack.frame.size.width*2+50)
        xAxis = navigView.frame.size.width/2-width/2
        yAxis = btnBack.frame.origin.y
        height = 30
        
        let lblMovieDetails = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        lblMovieDetails.backgroundColor = UIColor.clearColor()
        lblMovieDetails.text = "About Us"
        lblMovieDetails.font = UIFont(name: "Helvetica Neue", size: 18)
        lblMovieDetails.textColor = UIColor.whiteColor()
        lblMovieDetails.textAlignment = NSTextAlignment.Center
        navigView.addSubview(lblMovieDetails)
        
        
        width = navigView.frame.size.width
        xAxis = navigView.frame.size.width/2-width/2
        yAxis = navigView.frame.size.height+5
        height = 30
        
        let lblWhat = UILabel(frame: CGRect(x: xAxis,y: yAxis,width: width,height: height))
        lblWhat.backgroundColor = UIColor.clearColor()
        lblWhat.text = "What is the app about ?"
        lblWhat.font = UIFont(name: "Helvetica Neue", size: 16)
        lblWhat.textColor = UIColor.whiteColor()
        lblWhat.textAlignment = NSTextAlignment.Center
        self.view.addSubview(lblWhat)
        
        designTableVeiw()
    }
    
    //MARK: - Table view design
    func designTableVeiw() {
        //Designing table view
        let width:CGFloat = self.view.frame.width
        let height:CGFloat = self.view.frame.size.height-(104)
        let xAxis:CGFloat = 0
        let yAxis:CGFloat = 104
        
        tableViewAboutUS = UITableView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height), style: UITableViewStyle.Plain)
        tableViewAboutUS.tag = 1
        tableViewAboutUS.layoutSubviews()
        tableViewAboutUS.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableViewAboutUS.allowsMultipleSelectionDuringEditing = false
        tableViewAboutUS.delegate = self
        tableViewAboutUS.dataSource = self
        tableViewAboutUS.backgroundColor = UIColor.blackColor()
        tableViewAboutUS.separatorStyle = UITableViewCellSeparatorStyle.None
        tableViewAboutUS.showsVerticalScrollIndicator = false
        tableViewAboutUS.showsHorizontalScrollIndicator = false
        tableViewAboutUS.rowHeight = 50;
        tableViewAboutUS.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableViewAboutUS)
        
        
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(100000000 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            print("table reload called")
            self.tableViewAboutUS.reloadData()
        }
    }

    
    //MARK: - Table delegate and data source
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "AboutUSTableViewCell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier)
        
        if cell == nil{
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
            
            let iconImageView = UIImageView()
            iconImageView.frame = CGRect(x: 15, y: 10, width: 12, height: 12)
            iconImageView.image = UIImage(named: "Dot")
            
            // you have to add the imageview to the content view of the cell
            cell.contentView.addSubview(iconImageView)
            
            //Dont remove this. setting image inorder to move textLabel position.
            cell.imageView?.image = UIImage(named: "Dot")
            cell.imageView?.alpha = 0
        }
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let dictItem = arrayAboutUS[(indexPath as NSIndexPath).row] as! String
        
        cell.textLabel?.text = dictItem
        cell.textLabel?.numberOfLines = 10
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell!
    }

    
    // number of rows in table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayAboutUS.count
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).row == 0{
            return 80
        }
        if (indexPath as NSIndexPath).row == 1{
            return 30
        }
        if (indexPath as NSIndexPath).row == 2{
            return 50
        }
        if (indexPath as NSIndexPath).row == 3{
            return 50
        }
        if (indexPath as NSIndexPath).row == 4{
            return 30
        }
        else{
            return 60
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected item: \((indexPath as NSIndexPath).row)  withItem: \(arrayAboutUS[(indexPath as NSIndexPath).row])")
    }
    
    func dismissVC () {
        navigCRefeAboutUS?.navigationBar.hidden = false
        navigCRefeAboutUS?.navigationBarHidden = false
        navigCRefeAboutUS!.popToViewController(controlCRefeAboutUS!, animated: true)
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
