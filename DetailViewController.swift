//
//  DetailViewController.swift
//  parkingBee
//
//  Created by MTSS User on 11/10/15.
//  Copyright © 2015 ParkingBee. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {
    @IBOutlet weak var bookButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookButton.layer.cornerRadius = 5.0
    }
    
    @IBAction func bookSpotButtonPressed(sender: AnyObject) {
        if PFUser.currentUser() == nil {
            print("NO USER :(")

            self.performSegueWithIdentifier("noUserSegue", sender: self)
            
        }
        
        
        
    }
    
}
