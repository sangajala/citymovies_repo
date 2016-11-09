//
//  TheatersTableViewCell.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 12/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit

class TheatersTableViewCell: UITableViewCell {
    
    var lblTitle = UILabel()
    var imgViewMovies = UIImageView()
    var lblAddress = UILabel()
    var lblNumberOfScreens = UILabel()
    var lblScreen = UILabel()
    
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, frameCell: CGRect) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.backgroundColor = UIColor.clearColor()
        
        var width:CGFloat = frameCell.size.width/2-20
        var height:CGFloat = frameCell.size.height
        var xAxis:CGFloat = 0
        var yAxis:CGFloat = 0
        
        imgViewMovies = UIImageView(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        imgViewMovies.userInteractionEnabled = true
        imgViewMovies.backgroundColor = UIColor.clearColor()
        imgViewMovies.contentMode = UIViewContentMode.ScaleAspectFill
        imgViewMovies.clipsToBounds = true
        imgViewMovies.image = UIImage(named: "Moviestartwars")
        self.addSubview(imgViewMovies)
        
        
        width = frameCell.size.width/2-30
        height = 30
        xAxis = imgViewMovies.frame.size.width+15
        yAxis = 2
        
        lblTitle = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle.text = ""
        lblTitle.textColor = UIColor.whiteColor()
        lblTitle.backgroundColor = UIColor.clearColor()
        lblTitle.textAlignment = NSTextAlignment.Left
        lblTitle.numberOfLines = 2
        lblTitle.font = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
        self.addSubview(lblTitle)
        
        
        width = frameCell.size.width/2-30
        height = 55
        xAxis = imgViewMovies.frame.size.width+15
        yAxis = lblTitle.frame.size.height+lblTitle.frame.origin.y-5
        
        lblAddress = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblAddress.text = "Railway New Colony Road, Near Piaggio Motors, Railway New Colony, Visakhapatnam, Andhra Pradesh 5300"
        lblAddress.textColor = UIColor.init(colorLiteralRed: 109/255.0, green: 111/255.0, blue: 119/255.0, alpha: 1.0)
        lblAddress.backgroundColor = UIColor.clearColor()
        lblAddress.textAlignment = NSTextAlignment.Left
        lblAddress.numberOfLines = 10
        lblAddress.font = UIFont.systemFontOfSize(12.0)
        self.addSubview(lblAddress)
        
        width = 20
        height = 15
        xAxis = imgViewMovies.frame.size.width+15
        yAxis = lblAddress.frame.size.height+lblAddress.frame.origin.y-5
        
        lblNumberOfScreens = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblNumberOfScreens.text = "3"
        lblNumberOfScreens.textColor = UIColor(red: 27/255, green: 207/255, blue: 240/255, alpha: 1.0)
        lblNumberOfScreens.backgroundColor = UIColor.clearColor()
        lblNumberOfScreens.textAlignment = NSTextAlignment.Left
        lblNumberOfScreens.numberOfLines = 2
        lblNumberOfScreens.font = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
        self.addSubview(lblNumberOfScreens)
        
        
        width = 50
        height = 15
        xAxis = lblNumberOfScreens.frame.size.width+lblNumberOfScreens.frame.origin.x
        yAxis = lblAddress.frame.size.height+lblAddress.frame.origin.y-5
        
        lblScreen = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblScreen.text = "Screens"
        lblScreen.textColor = UIColor.init(colorLiteralRed: 109/255.0, green: 111/255.0, blue: 119/255.0, alpha: 1.0)
        lblScreen.backgroundColor = UIColor.clearColor()
        lblScreen.textAlignment = NSTextAlignment.Left
        lblScreen.numberOfLines = 2
        lblScreen.font = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
        self.addSubview(lblScreen)
        
        
    }
    
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
