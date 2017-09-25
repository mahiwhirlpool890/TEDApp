//
//  ProgressBarUtility.swift
//  WhirlpoolWcloudBaseApp
//
//  Created by Vikram Naik on 11/09/17.
//  Copyright © 2017 whirlpool. All rights reserved.
//

import UIKit
import RPCircularProgress

class ProgressBarUtility: NSObject {
    
    private var progress:RPCircularProgress! = nil
    
    class var sharedInstance :ProgressBarUtility {
        struct Singleton {
            static let instance = ProgressBarUtility()
        }
        return Singleton.instance
    }
    override init() {
        progress = RPCircularProgress()
        var rect =  progress.frame
        rect.size.height = 100
        rect.size.width = 100
        progress.frame = rect
    }
    open  func getThinProgress() -> RPCircularProgress {
    
        progress.progressTintColor = UIColor.blue
        progress.trackTintColor = UIColor.gray
        progress.thicknessRatio = 0.3
        progress.enableIndeterminate()
        return progress
    }
    open  func showThinProgressView(view :UIView ) -> Void {
        
        progress = getThinProgress()
        progress.center = (view.superview?.convert(view.center, to: progress.superview))!
        view.addSubview(progress)
        
    }
    
    
    open  func removeProgressView(view :UIView ) -> Void {
        
        if let progress = getProgressViewforView(fromView:view){
            progress.removeFromSuperview()
            
        }
        
        
    }
    
    open func getProgressViewforView(fromView :UIView ) -> RPCircularProgress! {
        for case let progress as RPCircularProgress in fromView.subviews {
            return progress
        }
        return nil
    }
    open  func setFrameForProgressView() -> Void {
        
    }
    
    
}
