//
//  LogInViewController.swift
//  parkingBee
//
//  Created by MTSS User on 11/10/15.
//  Copyright © 2015 ParkingBee. All rights reserved.



import UIKit
import Parse
import ParseFacebookUtilsV4
class LogInViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePicture.clipsToBounds = true
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        
    }
    
    @IBAction func closePage(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func logInWithFacebook(sender: AnyObject) {
        let permissions = ["public_profile","email"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    print("User signed up and logged in through Facebook!")
                  self.loadDataAndSaveData()
                } else {
                    print("User logged in through Facebook!")
                    self.loadDataAndSaveData()
                }
            }; if user == nil {
                print("Uh oh. The user cancelled the Facebook login.")
            }
        }
        
    }
    
    
    
    
    func saveUserData(userName:String, userEmail:String, pictureURL:NSURL, userID:String) {
        PFUser.currentUser()?.username = userName
        PFUser.currentUser()?.setObject(userID, forKey: "FacebookID")
        PFUser.currentUser()?.setObject(pictureURL, forKey: "pictureURL")
        PFUser.currentUser()?.setObject(userEmail, forKey: "email")
        PFUser.currentUser()?.saveInBackgroundWithBlock(nil)
        PFUser.currentUser()?.saveInBackground()
    }
    
    func loadDataAndSaveData() {
        let request: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"])
        request.startWithCompletionHandler { (connection, result, error) -> Void in
            if error == nil {
                
                let facebookID = result["id"] as! String
                let email = result["email"] as! String
                let userName = result["name"]as! String
                let pictureURL: NSURL = NSURL(string: NSString(string: "https://graph.facebook.com/\(facebookID)/picture?type=large&return_ssl_resources=1") as String)!
                
                // save data
                //self.saveUserData(userName, userEmail: email, pictureURL: pictureURL, userID: facebookID)
                
                PFUser.currentUser()?.username = userName
                PFUser.currentUser()?.setObject(facebookID, forKey: "FacebookID")
                //PFUser.currentUser()?.setObject(pictureURL, forKey: "pictureURL")
                PFUser.currentUser()?.setObject(email, forKey: "email")
                PFUser.currentUser()?.saveInBackgroundWithBlock(nil)
                PFUser.currentUser()?.saveInBackground()
                

                //Set profile picture
                let urlRequest: NSURLRequest = NSURLRequest(URL: pictureURL)
              /*  NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                    if (error == nil) && (data != nil) {
                        self.profilePicture.image = UIImage(data: data!)
                        self.userName.text = email
                    }
                }) */
            
            }
        }
    }
}
