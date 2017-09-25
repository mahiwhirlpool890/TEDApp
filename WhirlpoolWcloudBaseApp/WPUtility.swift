//
//  WPUtility.swift
//  WhirlpoolWcloudBaseApp
//
//  Created by PUGMACMINI on 21/09/17.
//  Copyright © 2017 whirlpool. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import AVFoundation

class WPUtility: NSObject {
    
    class func makeButtonOvalShapeWithBGColor(btn:UIButton,i:CGFloat)->Void
    {       
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = (btn.frame.size.width)/i
        btn.layer.masksToBounds = true
        
    }
    
    class func getSSID() -> NSString? {
        
        let interfaces = CNCopySupportedInterfaces()
        if interfaces == nil {
            return nil
        }
        
        let interfacesArray = interfaces as! [String]
        if interfacesArray.count <= 0 {
            return nil
        }
        
        let interfaceName = interfacesArray[0] as String
        let unsafeInterfaceData =     CNCopyCurrentNetworkInfo(interfaceName as CFString)
        if unsafeInterfaceData == nil {
            return nil
        }
        
        let interfaceData = unsafeInterfaceData as! Dictionary <String,AnyObject>
        
        return interfaceData["SSID"] as? NSString
    }

    
}


