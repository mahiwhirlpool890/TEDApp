//
//  FirstViewController.swift
//  WhirlpoolWcloudBaseApp
//
//  Created by Vikram Naik on 08/09/17.
//  Copyright © 2017 whirlpool. All rights reserved.
//

import UIKit
import RPCircularProgress
import FacebookLogin
import GoogleSignIn



class WPLoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
   
    @IBOutlet var faceBookView: UIView!
    @IBOutlet var googleView: UIView!
    @IBOutlet var connectToEmailBtn: UIButton!
    @IBOutlet var facebookIconImg: UILabel!
    @IBOutlet var googleIconImg: UILabel!
    
    
    
    private var progress:RPCircularProgress! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        faceBookView.layer.borderWidth = 1.0
        googleView.layer.borderWidth = 1.0
        connectToEmailBtn.layer.borderWidth = 1.0
        facebookIconImg.layer.borderWidth = 1.0
        googleIconImg.layer.borderWidth = 1.0
        
        
        faceBookView.layer.borderColor = UIColor.white.cgColor
        googleView.layer.borderColor = UIColor.white.cgColor
        connectToEmailBtn.layer.borderColor = UIColor.white.cgColor
        facebookIconImg.layer.borderColor = UIColor.white.cgColor
        googleIconImg.layer.borderColor = UIColor.white.cgColor

        
        faceBookView.layer.cornerRadius = faceBookView.frame.size.width/8;
        self.faceBookView.layer.masksToBounds = true
        
        googleView.layer.cornerRadius = googleView.frame.size.width/8
         self.googleView.layer.masksToBounds = true
        
        connectToEmailBtn.layer.cornerRadius = connectToEmailBtn.frame.size.width/15
        self.connectToEmailBtn.layer.masksToBounds = true
        
        
        facebookIconImg.layer.cornerRadius = facebookIconImg.frame.size.width/2
        self.facebookIconImg.layer.masksToBounds = true
        
        
        googleIconImg.layer.cornerRadius = googleIconImg.frame.size.width/2
        self.googleIconImg.layer.masksToBounds = true
        
        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    @IBAction func loginWithGoogle(_ sender: Any) {
       
        GIDSignIn.sharedInstance().uiDelegate = self;
        GIDSignIn.sharedInstance().delegate = self        
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    @IBAction func loginWithFacebook(_ sender: Any) {
        
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email,.userFriends ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, _):
                print("Logged in!")
            }
       }
    }
    @IBAction func LoginBtnClicked(_ sender: Any) {
       
        ProgressBarUtility.sharedInstance.showThinProgressView(view: self.view)
        
        NetworkCallController.sharedInstance.loginWith(email: "ja_dish123@mailinator.com", password: "Smart2000"){ responseJson in
            
            ProgressBarUtility.sharedInstance.removeProgressView(view :self.view)
            
            guard responseJson.result.error == nil else {
            // MARK: got an error in getting the data, need to handle it
                print("error calling POST on /todos/1")
                print(responseJson.result.error!)
                return
            }
            
            // MARK: make sure we got some JSON since that's what we expect
            guard let json = responseJson.result.value as? [String: Any] else {
                print("didn't get todo object as JSON from API")
                //                    print("Error: \(response.result.error)")
                return
            }
           // MARK: get and print the title
            guard let accessToken = json["access_token"] as? String else {
                print("Could not get todo title from JSON")
                return
            }
            
            // MARK: create the alert
            let alert = UIAlertController(title: "Response", message: "Access Token is "+accessToken, preferredStyle: UIAlertControllerStyle.alert)
            
            // MARK: add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
           // MARK: show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    // MARK: Google Delegate Method
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error == nil{
            
            let storyboard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            
            let  objConfigurVC = storyboard.instantiateViewController(withIdentifier: "WPConfigurePopupVC")
            
             self.navigationController?.pushViewController(objConfigurVC, animated: true)
            
            
        }
    }
    
    
    
}






