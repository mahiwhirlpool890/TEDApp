//
//  WPUtility.swift
//  WhirlpoolWcloudBaseApp
//
//  Created by PUGMACMINI on 21/09/17.
//  Copyright © 2017 whirlpool. All rights reserved.
//

import UIKit

class WPUtility: NSObject {
    
    class func makeButtonOvalShapeWithBGColor(btn:UIButton,i:CGFloat)->Void
    {       
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = (btn.frame.size.width)/i
        btn.layer.masksToBounds = true
        
    }
    
}


