//
//  DetailViewController.swift
//  parkingBee
//
//  Created by MTSS User on 11/10/15.
//  Copyright © 2015 ParkingBee. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var parkingspotImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookButton.layer.cornerRadius = 5.0
        self.parkingspotImage.clipsToBounds = true
        

    }

   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    let cellIdentifier = "cell"
    let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
    
   return cell
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 73.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    @IBAction func bookSpotButtonPressed(sender: AnyObject) {
        if PFUser.currentUser() == nil {
            print("NO USER :(")

            self.performSegueWithIdentifier("noUserSegue", sender: self)
            
        }
        
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = UIColor(red: 255.0/255.0, green: 185.0/255.0, blue: 58.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255.0/255.0, green: 185.0/255.0, blue: 58.0/255.0, alpha: 1.0)
        navigationItem.backBarButtonItem = backItem
    }
    
}
    

