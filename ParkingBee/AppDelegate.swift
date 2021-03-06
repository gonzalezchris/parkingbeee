//
//  AppDelegate.swift
//  parkingBee
//
//  Created by Bingyao Li on 11/8/15.
//  Copyright © 2015 ParkingBee. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Parse
import Bolts
import ParseFacebookUtilsV4

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //FBSDKAppEvents.activateApp()
        //FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        //Parse.enableLocalDatastore()
       
        Parse.setApplicationId("rgMdaZeJsX181TmJzdbOda05YGMHOG0xtCD7UWXv",
            clientKey: "4K6W6DGRiBZNqT5ZZ7FsqgrRnbSWskHG0A9XxyGX")
        
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)

        let navBarFont = UIFont(name: "HelveticaNeue-Light", size: 25.0)

        
         UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: navBarFont!, NSForegroundColorAttributeName: UIColor(red: 255.0/255.0, green: 185.0/255.0, blue: 58.0/255.0, alpha: 1.0)]
       // UINavigationBar.appearance().translucent = false
        

        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    
    }

    func applicationWillTerminate(application: UIApplication) {
        
    }
    
  
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

}

