//
//  WPConnectPhoneVC.swift
//  WhirlpoolWcloudBaseApp
//
//  Created by PUGMACMINI on 25/09/17.
//  Copyright © 2017 whirlpool. All rights reserved.
//

import UIKit
import CocoaAsyncSocket

class WPConnectPhoneVC: UIViewController, GCDAsyncUdpSocketDelegate {

    var udpSockett:GCDAsyncUdpSocket!;
    let IP = "90.112.76.180"
    let PORT:UInt16 = 5556
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupConnection()
        // Do any additional setup after loading the view.
    }

    // MARK: UDPSocketDelegate
    
    func setupConnection(){
        let error : NSError = NSError()
        udpSockett = GCDAsyncUdpSocket(delegate: self, delegateQueue: DispatchQueue.main)
        
        do {
            try  udpSockett.connect(toHost: IP, onPort: PORT)
        } catch _ {
            print(error.description)
        }
        
    }
    
    func send(message:String){
        let data = message.data(using: String.Encoding.utf8)
        udpSockett.send(data!, withTimeout: 2, tag: 0)
    }
    
    private func udpSocket(sock: GCDAsyncUdpSocket!, didConnectToAddress address: Data!) {
        print("didConnectToAddress");
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotConnect error: Error?) {
        print("didNotConnect \(error ?? "connected" as! Error)")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didSendDataWithTag tag: Int) {
        print("didSendDataWithTag")
    }
    
    private func udpSocket(sock: GCDAsyncUdpSocket!, didNotSendDataWithTag tag: Int, dueToError error: Error!) {
        print("didNotSendDataWithTag")
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
