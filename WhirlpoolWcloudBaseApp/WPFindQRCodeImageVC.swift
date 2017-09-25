//
//  WPFindQRCodeImageVC.swift
//  WhirlpoolWcloudBaseApp
//
//  Created by PUGMACMINI on 22/09/17.
//  Copyright © 2017 whirlpool. All rights reserved.
//

import UIKit

class WPFindQRCodeImageVC: UIViewController {
    @IBOutlet var continueBtn: UIButton!
    
       
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // MARK: - Making buttons in Oval shape
        WPUtility.makeButtonOvalShapeWithBGColor(btn: self.continueBtn, i: self.continueBtn.frame.size.width/20)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueAction(_ sender: Any) {
        
        let storyboard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let  objScanQRCodeVC = storyboard.instantiateViewController(withIdentifier: "WPScanQRCodeVC")
        
        self.navigationController?.pushViewController(objScanQRCodeVC, animated: true)
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
