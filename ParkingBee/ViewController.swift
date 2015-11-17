//
//  ViewController.swift
//  parkingBee
//
//  Created by Bingyao Li on 11/8/15.
//  Copyright © 2015 ParkingBee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class ViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var informationView: UIView!
    @IBOutlet var selectButton: UIButton!
    
    var geoCoder: CLGeocoder!
    var searchController: UISearchController!
    var localSearchRequest: MKLocalSearchRequest!
    var localSearch: MKLocalSearch!
    var localSearchResponse: MKLocalSearchResponse!
    var annotation: MKAnnotation!
    var pointAnnotation: MKPointAnnotation!
    var pointAnnotation2: MKPointAnnotation!
    var pointAnnotation3: MKPointAnnotation!
    var pinAnnotationView: MKPinAnnotationView!
    var pinAnnotationView2: MKPinAnnotationView!
    var pinAnnotationView3: MKPinAnnotationView!
    
    let locationManager = CLLocationManager()
    
    var secondLocation: CLLocation!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.informationView.center.x -= view.bounds.height
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.selectButton.layer.cornerRadius = 5.0
        let initialLocation = CLLocation(latitude: 40.8142810, longitude: -77.8862260)
        //centerMapOnLocation(initialLocation)
        UIView.animateWithDuration(1.0, delay: 0.4, options: .CurveEaseOut, animations: {self.informationView.center.x += self.view.bounds.height}, completion: nil)
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()

        }
        
        
        // Load Parking spots available
        self.displayParkingSpotsNearby()
        
        // Edit the navigation bar title FONT and COLOR
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor(red: 255.0/255.0, green: 185.0/255.0, blue: 58.0/255.0, alpha: 1.0)]
        
        let navBarFont = UIFont(name: "Helvetica", size: 25.0)
        let navBarAttributesDictionary: [NSObject: AnyObject]? = [NSForegroundColorAttributeName: UIColor(red: 255.0/255.0, green: 185.0/255.0, blue: 58.0/255.0, alpha: 1.0), NSFontAttributeName: navBarFont!]

        //navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
        
       
    }
    
    @IBAction func showSearchBar(sender: AnyObject) {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
        
    }
    
    func geoCode(location: CLLocation!) {
       geoCoder = CLGeocoder()
        geoCoder.cancelGeocode()
        geoCoder.reverseGeocodeLocation(location) { (data, error)  -> Void in
            guard let placeMarks = data as [CLPlacemark]! else {
                return
            }
            
            let loc: CLPlacemark = placeMarks[0]
            let addressDict : [NSString:NSObject] = loc.addressDictionary as! [NSString: NSObject]
            let addrList = addressDict["FormattedAddressLines"] as! [String]
            print(loc.locality)
            
            
        }
        
        
    }
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
        
        
          geoCode(location)
        
        
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

    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
        if self.mapView.annotations.count != 0 {
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            if localSearchResponse == nil {
                let alertController = UIAlertController(title: nil, message: "Place not found", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchBar.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
            
            
            
        }
    }
    
    
    func displayParkingSpotsNearby() {
        self.pointAnnotation = MKPointAnnotation()
        self.pointAnnotation2 = MKPointAnnotation()
        self.pointAnnotation3 = MKPointAnnotation()
        
        self.pointAnnotation.title = "$10/Day"
        self.pointAnnotation2.title = "$8/Day"
        self.pointAnnotation3.title = "$9/Day"
        
        self.pointAnnotation.subtitle = "Vairo Blvd"
        
        self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.8194810  , longitude: -77.8863240)
        self.pointAnnotation2.coordinate = CLLocationCoordinate2D(latitude: 40.8154810, longitude: -77.8861140)
        self.pointAnnotation3.coordinate = CLLocationCoordinate2D(latitude: 40.8135110, longitude: -77.8869000)
        
        self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
        self.pinAnnotationView2 = MKPinAnnotationView(annotation: self.pointAnnotation2, reuseIdentifier: nil)
        self.pinAnnotationView3 = MKPinAnnotationView(annotation: self.pointAnnotation3, reuseIdentifier: nil)
        
        //self.mapView.centerCoordinate = self.pointAnnotation.coordinate
        
        self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
        self.mapView.addAnnotation(self.pinAnnotationView2.annotation!)
        self.mapView.addAnnotation(self.pinAnnotationView3.annotation!)
        print("parking spots displayed")
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = UIColor(red: 255.0/255.0, green: 185.0/255.0, blue: 58.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255.0/255.0, green: 185.0/255.0, blue: 58.0/255.0, alpha: 1.0)
        navigationItem.backBarButtonItem = backItem
    }

}

















