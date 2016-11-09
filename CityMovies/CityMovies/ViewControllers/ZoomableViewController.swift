//
//  ZoomableViewController.swift
//  CityMovies
//
//  Created by Deepthi Kaligi on 15/06/2016.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit
import Kingfisher

class ZoomableViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var  pic : UIImageView!
    
    
    var tapGesture : UITapGestureRecognizer!
    
    var str : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: URL!) -> Void in
//            print(self)
//        }
//        pic.sd_setImage(with: NSURL(string:str!), completed: block)
        
        let imgPlaceholder = UIImage(named: "placeholder_movie")
        
        //ImagedNeeded
        pic.kf_setImageWithURL(NSURL(string:str!)!, placeholderImage: imgPlaceholder, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        
        tapGesture = UITapGestureRecognizer(target: self, action: (#selector(ZoomableViewController.zoomInOrOut(_:))))
        tapGesture.numberOfTapsRequired = 2
        pic.userInteractionEnabled = true
        pic.addGestureRecognizer(tapGesture)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return pic
    }
    
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func  zoomInOrOut(gesture : UITapGestureRecognizer) {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else if scrollView.zoomScale == scrollView.maximumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else if scrollView.zoomScale == scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    
}
