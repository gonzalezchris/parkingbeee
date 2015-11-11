//
//  ViewController.swift
//  parkingBee
//
//  Created by Bingyao Li on 11/8/15.
//  Copyright © 2015 ParkingBee. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var informationView: UIView!
    
    @IBOutlet var selectButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.informationView.center.x -= view.bounds.height
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.selectButton.layer.cornerRadius = 5.0
        
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
        UIView.animateWithDuration(1.0, delay: 0.4, options: .CurveEaseOut, animations: {self.informationView.center.x += self.view.bounds.height}, completion: nil)
    }

    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

