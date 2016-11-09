//
//  VideoCollectionViewCell.swift
//  CityMovies
//
//  Created by Deepthi Kaligi on 08/06/2016.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    var webView : UIWebView!
    var videourl : String!
    
    
    init(frame : CGRect , reuseIdentifier : String, videoURL : String) {
        super.init(frame : frame)
        print("in the convience init")
        videourl = videoURL
        
    }
    
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        print("in the designated init")
        
        webView = UIWebView(frame: CGRect(x: 10,y: 10,width: 60,height: 40))
        //     let u = NSURL(string: "https://www.youtube.com/watch?v=t_FtkvfgYUo")
        //     let r = NSURLRequest(URL: u!)
        //    webView.loadRequest(r)
        self.contentView.addSubview(webView)
        self.backgroundColor = UIColor.brownColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        print("in the  init with coder")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.webView.frame = self.contentView.bounds
    }
    
}
