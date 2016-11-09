//
//  MoviesTableViewCell.swift
//  CityMovies
//
//  Created by Goutham Devaraju on 17/05/16.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    var lblTitle = UILabel()
    var imgViewMovies = UIImageView()
    var lblRating = UILabel()
    var lblTime = UILabel()
    var lblGener = UILabel()
    var lblCast = UILabel()
    
    
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
        height = 40
        xAxis = imgViewMovies.frame.size.width+15
        yAxis = 5
        
        lblTitle = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTitle.text = ""
        lblTitle.textColor = UIColor.whiteColor()
        lblTitle.backgroundColor = UIColor.clearColor()
        lblTitle.textAlignment = NSTextAlignment.Left
        lblTitle.numberOfLines = 2
        lblTitle.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        self.addSubview(lblTitle)
        
        
        xAxis = imgViewMovies.frame.size.width+15
        yAxis = lblTitle.frame.size.height+lblTitle.frame.origin.y
        width = (frameCell.size.width/2-15)/3
        height = 10
        
        let lblRatingTitle = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblRatingTitle.text = "RATING- "
        lblRatingTitle.textColor = UIColor.init(colorLiteralRed: 109/255.0, green: 111/255.0, blue: 119/255.0, alpha: 1.0)
        lblRatingTitle.backgroundColor = UIColor.clearColor()
        lblRatingTitle.textAlignment = NSTextAlignment.Left
        lblRatingTitle.numberOfLines = 3
        lblRatingTitle.font = UIFont.systemFontOfSize(10.0)
        self.addSubview(lblRatingTitle)
        
        
        width = (frameCell.size.width/2-15)/5
        height = 10
        xAxis = lblRatingTitle.frame.size.width+lblRatingTitle.frame.origin.x
        yAxis = lblTitle.frame.size.height+lblTitle.frame.origin.y
        
        lblRating = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblRating.text = "99.99"
        lblRating.textColor = UIColor(red: 27/255, green: 207/255, blue: 240/255, alpha: 1.0)
        lblRating.backgroundColor = UIColor.clearColor()
        lblRating.textAlignment = NSTextAlignment.Center
        lblRating.numberOfLines = 3
        lblRating.font = UIFont.systemFontOfSize(10.0)
        self.addSubview(lblRating)
        
        
        width = (frameCell.size.width/2-15)/5
        height = 10
        xAxis = lblRating.frame.size.width+lblRating.frame.origin.x+3
        yAxis = lblTitle.frame.size.height+lblTitle.frame.origin.y
        
        let lblTimeTitle = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTimeTitle.text = "TIME: "
        lblTimeTitle.textColor = UIColor.init(colorLiteralRed: 109/255.0, green: 111/255.0, blue: 119/255.0, alpha: 1.0)
        lblTimeTitle.backgroundColor = UIColor.clearColor()
        lblTimeTitle.textAlignment = NSTextAlignment.Left
        lblTimeTitle.numberOfLines = 3
        lblTimeTitle.font = UIFont.systemFontOfSize(10)
        self.addSubview(lblTimeTitle)
        
        
        width = (frameCell.size.width/2-15)/3
        height = 10
        xAxis = lblTimeTitle.frame.size.width+lblTimeTitle.frame.origin.x
        yAxis = lblTitle.frame.size.height+lblTitle.frame.origin.y
        
        lblTime = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblTime.text = "24H 59M"
        lblTime.textColor = UIColor.init(colorLiteralRed: 109/255.0, green: 111/255.0, blue: 119/255.0, alpha: 1.0)
        lblTime.backgroundColor = UIColor.clearColor()
        lblTime.textAlignment = NSTextAlignment.Center
        lblTime.numberOfLines = 3
        lblTime.font = UIFont.systemFontOfSize(10.0)
        self.addSubview(lblTime)
        
        
        width = frameCell.size.width/2-30
        height = 10
        xAxis = imgViewMovies.frame.size.width+15
        yAxis = lblTime.frame.size.height+lblTime.frame.origin.y+5
        
        lblGener = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblGener.text = "Thriller/Action"
        lblGener.textColor = UIColor.init(colorLiteralRed: 109/255.0, green: 111/255.0, blue: 119/255.0, alpha: 1.0)
        lblGener.backgroundColor = UIColor.clearColor()
        lblGener.textAlignment = NSTextAlignment.Left
        lblGener.numberOfLines = 3
        lblGener.font = UIFont.systemFontOfSize(10)
        self.addSubview(lblGener)
        
        
        width = (frameCell.size.width/2-15)/4
        height = 10
        xAxis = imgViewMovies.frame.size.width+15
        yAxis = lblGener.frame.size.height+lblGener.frame.origin.y+5
        
        let lblCastTitle = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblCastTitle.text = "Cast : "
        lblCastTitle.textColor = UIColor.init(colorLiteralRed: 109/255.0, green: 111/255.0, blue: 119/255.0, alpha: 1.0)
        lblCastTitle.backgroundColor = UIColor.clearColor()
        lblCastTitle.textAlignment = NSTextAlignment.Left
        lblCastTitle.numberOfLines = 3
        lblCastTitle.font = UIFont.systemFontOfSize(10.0)
        self.addSubview(lblCastTitle)
        
        
        width = (frameCell.size.width/2-15)-width
        height = 10
        xAxis = lblCastTitle.frame.size.width+lblCastTitle.frame.origin.x+5
        yAxis = lblGener.frame.size.height+lblGener.frame.origin.y+5
        
        lblCast = UILabel(frame: CGRect(x: xAxis, y: yAxis, width: width, height: height))
        lblCast.text = "Nani, Niveda"
        lblCast.textColor = UIColor.init(colorLiteralRed: 109/255.0, green: 111/255.0, blue: 119/255.0, alpha: 1.0)
        lblCast.backgroundColor = UIColor.clearColor()
        lblCast.textAlignment = NSTextAlignment.Center
        lblCast.numberOfLines = 3
        lblCast.font = UIFont.systemFontOfSize(10.0)
        self.addSubview(lblCast)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
