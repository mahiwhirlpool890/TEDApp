//
//  WPConfigurePopupVC.swift
//  WhirlpoolWcloudBaseApp
//
//  Created by PUGMACMINI on 21/09/17.
//  Copyright © 2017 whirlpool. All rights reserved.
//

import UIKit



class WPConfigurePopupVC: UIViewController {

    @IBOutlet var setupNowBtn: UIButton!
    @IBOutlet var setupAfterBtn: UIButton!
    
   
    override func viewDidLoad() {
       
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // MARK:TODO - Making buttons in Oval shape
        WPUtility.makeButtonOvalShapeWithBGColor(btn: self.setupNowBtn, i: self.setupNowBtn.frame.size.width/20)
        WPUtility.makeButtonOvalShapeWithBGColor(btn: self.setupAfterBtn, i: self.setupAfterBtn.frame.size.width/20)
        
        
    }
    
    // MARK: - IBActions
    @IBAction func setupNowAction(_ sender: Any) {
        
        let storyboard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let  objFindQRCode = storyboard.instantiateViewController(withIdentifier: "WPFindQRCodeImageVC")
        
        self.navigationController?.pushViewController(objFindQRCode, animated: true)
        
    }
    @IBAction func setupAfterAction(_ sender: Any) {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
