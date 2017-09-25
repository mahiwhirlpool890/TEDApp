//
//  WPScanQRCodeVC.swift
//  WhirlpoolWcloudBaseApp
//
//  Created by PUGMACMINI on 22/09/17.
//  Copyright © 2017 whirlpool. All rights reserved.
//

import UIKit
import AVFoundation

class WPScanQRCodeVC: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var applianceSAID: NSString!
    var applianceMAC: NSString!
    var isApplianceLCDCompatible: Bool!
    var isApplicableForEZConnect: Bool!
    
    
    @IBOutlet var scanningView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        startCameraScanning()
        
    }
    
    @objc func startCameraScanning() {
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = scanningView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        scanningView.layer.addSublayer(previewLayer)
        
         // Added delay to prevent crash if QR code is scanned immediately before views finish loading
        captureSession.perform(#selector(captureSession.startRunning) , with: nil, afterDelay: 0.1)
        
    }
    
    @objc func startSession(){
        
        captureSession.startRunning()
    }
    
    // MARK: AVCaptureMetadataOutputObjectsDelegate
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                                 didOutput metadataObjects: [AVMetadataObject],
                                 from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        print(metadataObjects.first ?? "")
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            extractApplianceSAIDFromString(scannedString: stringValue as NSString)
        }
        
        dismiss(animated: true)
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Custom Methods
    
    func extractApplianceSAIDFromString(scannedString:NSString)-> Void{
        
        // Removing whitespaces from scanned string
        let trimmedString = scannedString.trimmingCharacters(in: .whitespaces)
        scannedString.isEqual(to: trimmedString)
        
        if scannedString.substring(with: NSRange(location: 4, length: 1)).isEqual("=") &&
           scannedString.substring(with: NSRange(location: 19, length: 1)).isEqual("="){
            
            if scannedString.uppercased.range(of: "GUI") != nil{
                
                if scannedString.substring(with: NSRange(location: scannedString.length-2, length: 1)).isEqual("="){
                    
                }else {
                    
                    let alert:UIAlertController = UIAlertController.init(title: "Alert", message: "You have scanned the wrong code. Please make sure you scan the appliance QR Code", preferredStyle: .alert)
                    let okBtn = UIAlertAction.init(title: "OK", style:.destructive, handler: nil)
                    alert.addAction(okBtn)
                    self.show(alert, sender: nil)
                    captureSession.stopRunning()
                    return
                }
                
            }
            
            
            
            var containsGUI_ID:Bool = false
            let subStrings = NSMutableArray()
            
            let  scanner = Scanner(string: scannedString as String)
           
            scanner.scanUpTo("=", into: nil)
            
            while !scanner.isAtEnd{
                
                var subString:NSString? = nil
            
                scanner.scanString("=", into: nil)
                
                if  scanner.scanUpTo(";", into: &subString){
                    
                    subStrings.add(subString as Any)
                }
                
                scanner.scanUpTo("=", into: &subString)
            }
        
            // First string is the SAID. Second string is the MAC.
            // example: "333334G4X3", "88:E7:12:00:2D:BC"
            
            if ((subStrings.count>=1) && (scannedString.uppercased.range(of: "SAID") != nil) && (scannedString.uppercased.range(of: "MAC") != nil) &&
                ((subStrings[1] as AnyObject).length == 17)  &&
                ((subStrings[0] as AnyObject).length == 10)) ||
                    ((subStrings.count>=1) &&
                    (scannedString.uppercased.range(of: "SAID") != nil) &&
                    (scannedString.uppercased.range(of: "MAC") != nil) &&
                    ((subStrings[1] as AnyObject).length == 17)  &&
                    (scannedString.uppercased.range(of: "WPR") != nil) &&
                    ((subStrings[0] as AnyObject).length == 13)){
               
                
                self.applianceSAID = subStrings[0] as! NSString
                self.applianceMAC = subStrings[1] as! NSString
                
                var guiDetail:NSString? = nil
                
                if (subStrings.count>=3){
                    
                    guiDetail = (subStrings[2] as! NSString)
                }
                
                //IF substrings[2] from scanned Details is GUI=0 then appliance is not LCD compatible
                
                isApplianceLCDCompatible = ((guiDetail != nil) || (guiDetail == "0" ? true:false))
              
                
                //Check whether SAID start with digit "3" i.e "333334G4X3"
                
                var saidFirstLetter:NSString? = nil
                
                if self.applianceSAID.length>0{
                    
                    saidFirstLetter = self.applianceSAID.substring(to: 1) as NSString
                    
                }
                
                if scannedString.uppercased.range(of: "GUI") != nil{
                    
                    containsGUI_ID = true
                }
                
                isApplianceLCDCompatible = (saidFirstLetter?.isEqual(to: "3"))! && (!containsGUI_ID ? true:false)
               // isApplicableForEZConnect = ([saidFirstLetter isEqualToString:@"3"] && !containsGUI_ID)?NO:YES;
                
            
            }else{
                
                captureSession.stopRunning()
                alertForWrongQRCodeScanned()
            }
            
        }else{
            
            captureSession.stopRunning()
            alertForWrongQRCodeScanned()
            
        }
        
        
    }
    
    
    // MARK: - Alert for Wrong QR code scanned
    
    func alertForWrongQRCodeScanned() -> Void {
        
        let customView:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 150))
        let  imageView: UIImageView = UIImageView.init(frame: CGRect.init(x: 30, y: 10, width: 210, height: 50))
        imageView.contentMode = .center;
        imageView.image = UIImage.init(imageLiteralResourceName: "said")
        customView.addSubview(imageView)
        
        
        let msgLabel = UILabel.init(frame: CGRect.init(x: 20, y: imageView.frame.size.height + 20, width: 230, height: 80))
        msgLabel.font = UIFont.systemFont(ofSize: 14.0)
        msgLabel.textColor = UIColor.black
        msgLabel.textAlignment = .center
        msgLabel.numberOfLines = 5
        msgLabel.text = "You have scanned the wrong code. Please make sure you scan the appliance QR Code(as shown above)."
        customView.addSubview(msgLabel)
        
        
        let alert =  UIAlertController.init(title: "Wrong Code Scanned", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default){ action -> Void in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(UIAlertAction(title: "Can't Find Code", style: UIAlertActionStyle.default)
        { action -> Void in
           alert.dismiss(animated: true, completion: nil)
        })
        
        alert.view.addSubview(customView)
        
        DispatchQueue.main.async {
            self.present(alert, animated:true, completion: nil)
        }
        
      
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
