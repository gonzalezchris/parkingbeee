//
//  confirmViewController.swift
//  parkingBee
//
//  Created by Bingyao Li on 11/8/15.
//  Copyright © 2015 ParkingBee. All rights reserved.
//

import UIKit

class confirmViewController: UIViewController {

    
    @IBAction func confirmPressed(sender: AnyObject) {
        
        super.viewDidLoad()
        
        func myCallback() {
            self.performSegueWithIdentifier("successPay", sender: nil)
        }
        var alertview = JSSAlertView().success(self,
            title: "Thank You",
            text: "Your parking spot has been booked"
        )
        alertview.addAction(myCallback)
    }

    
    override func viewDidLoad() {
//        JSSAlertView().show(
//            self, // the parent view controller of the alert
//            title: "I'm an alert" // the alert's title
//        )
        super.viewDidLoad()

    }
    
    
}

