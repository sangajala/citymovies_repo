//
//  BookingTableViewCell.swift
//  CityMovies
//
//  Created by Deepthi Kaligi on 20/05/2016.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import UIKit
import WebKit

class BookingTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle : UILabel!
    @IBOutlet weak var bookButton : UIButton!
    var bookingScreen : UIViewController = UIViewController()
    var delegate : WebViewProtocol_?
    
    // create oulets for timings labels
    
    @IBAction func bookTicket(sender : UIButton) {
        NSLog("Booking event")
        if sender.tag == 0 {
            displayWebView("https://www.justickets.in")
            
        } else if sender.tag == 1 {
            displayWebView("https://www.paypal.com/in/webapps/mpp/home")
            
        }else if sender.tag == 2 {
            displayWebView("https://www.bookmyshow.com")
        }else {
            return
        }
    }
    
    
  
    func displayWebView ( _ string : String) {
        self.delegate?.presentBookingView!(string)
    }
  
    func  cancel() -> () {
        delegate?.cancelEvent(bookingScreen)
    }

}


@objc protocol WebViewProtocol_ {
   func  presentWebView(vc : UIViewController)
   func  cancelEvent(vc : UIViewController) -> ()
   @objc optional func presentBookingView(str : String)
}

