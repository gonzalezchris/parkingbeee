//
//  SubmitSpotViewController.swift
//  parkingBee
//
//  Created by MTSS User on 11/15/15.
//  Copyright © 2015 ParkingBee. All rights reserved.
//

import UIKit
import CoreLocation
import Parse

class SubmitSpotViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate  {
    @IBOutlet weak var spotLocationTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.spotLocationTextField.becomeFirstResponder()
        self.spotLocationTextField.delegate = self
        
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
       let address = self.spotLocationTextField.text
        var parkingSpot = PFObject(className: "ParkingSpots")
        
        var latitude: AnyObject!
        var longitude: AnyObject!
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address!, completionHandler: {(placemarks, error) -> Void in
            if let placemark = placemarks![0] as? CLPlacemark {
                //self.mapView.addAnnotation(placemark)
                
                latitude = placemark.location!.coordinate.latitude
                 longitude = placemark.location!.coordinate.longitude

            }
        })
       
        parkingSpot["latitude"] = latitude //as? AnyObject
        parkingSpot["longitude"] = longitude //as? AnyObject
        parkingSpot["host"] = PFUser.currentUser()?.username
        parkingSpot["address"] = address
        parkingSpot.saveInBackgroundWithBlock(nil)
        print("DONNEEEEEEEEEEEEEEEEEEE!!!!!")
        self.dismissViewControllerAnimated(true, completion: nil)
        
        return true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
