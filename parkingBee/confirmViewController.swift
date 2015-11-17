//
//  confirmViewController.swift
//  parkingBee
//
//  Created by Bingyao Li on 11/8/15.
//  Copyright © 2015 ParkingBee. All rights reserved.
//

import UIKit
import ParseFacebookUtilsV4
import Parse

class confirmViewController: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!
    
    @IBAction func confirmPressed(sender: AnyObject) {
        
        super.viewDidLoad()
        
        func myCallback() {
            self.performSegueWithIdentifier("successPay", sender: nil)
        }
        let customIcon = UIImage(named: "emoticon.png")
        let color = UIColor(red: 128.0/255.0, green: 200.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        let alertview = JSSAlertView().show(self,
            title: "Thank You",
            text: "Your parking spot has been booked",
            color: color,
            iconImage: customIcon
        )
        alertview.addAction(myCallback)
        alertview.setTextTheme(.Light)
        
    }

    
    override func viewDidLoad() {
//        JSSAlertView().show(
//            self, // the parent view controller of the alert
//            title: "I'm an alert" // the alert's title
//        )
        super.viewDidLoad()
        self.confirmButton.layer.cornerRadius = 5.0

    }
    
    @IBAction func logOutUser(sender: AnyObject) {
        
        PFUser.logOut()
        print(PFUser.currentUser())
        
    }
    
}

