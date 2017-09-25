//
//  WPConnectPhoneVC.swift
//  WhirlpoolWcloudBaseApp
//
//  Created by PUGMACMINI on 25/09/17.
//  Copyright © 2017 whirlpool. All rights reserved.
//



import UIKit
import CocoaAsyncSocket

let UDP_PORT_5551:int_fast16_t =    5551
let UDP_PORT_5550:int_fast16_t =    5550


class WPConnectPhoneVC: UIViewController, GCDAsyncUdpSocketDelegate {

    var udpSockett:GCDAsyncUdpSocket!;
    var invalidKey :Int!;
    var invalidPassphrase : Int!;
    var passLen : Int!;
    var passLength : Int!;
    var ssidLength,encryptedCustomDataLen : Int!;
    var passCRC,customDataCRC : CUnsignedLong!;
    var ssidCRC : CUnsignedLong!;
    var bssid : Array<CChar> = Array(repeating: 6, count: 6)
    var passphrase: Array<CChar> = Array(repeating: 32, count: 64)
    var ssid: Array<CChar> = Array(repeating: 32, count: 33)
    var preamble: Array<CChar> = Array(repeating: 6, count: 6)
    var timer : Timer!
    var timerCount : Int!;
    var timerMdns: Timer!;
    var linkStateTimer: Timer!;
    var count,lsTwoCount,customDataLen: Int!;
    var udpSocket5550:GCDAsyncUdpSocket!;
    var udpSocket5551:GCDAsyncUdpSocket!;
    var customData = [UInt8](repeating: 0, count: 32)
    var encryptedCustomData = [UInt8](repeating: 0, count: 32)
    var gotLSValueTwo,gotLSValueThree,isRunning5550,isActiveState:Bool!
    var currentSsid : NSString!;
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isActiveState = true
        timerCount = 0
        self.currentSsid = WPUtility.getSSID() as NSString!
        
        
        // Do any additional setup after loading the view.
    }

    // MARK: UDPSocketDelegate
    
    func startStopUDPConnection(){
        let error : NSError = NSError()
        udpSockett = GCDAsyncUdpSocket(delegate: self, delegateQueue: DispatchQueue.main)
        
        
        
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
    internal func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
        
        //NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        let msg = NSString(data:data, encoding:String.Encoding.utf8.rawValue)
        
        print(msg as Any);
        
    }
    
    func getIPAddresses() -> [String] {
        var addresses = [String]()
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return [] }
        guard let firstAddr = ifaddr else { return [] }
        
        // For each interface ...
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let flags = Int32(ptr.pointee.ifa_flags)
            var addr = ptr.pointee.ifa_addr.pointee
            
            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        let address = String(cString: hostname)
                        addresses.append(address)
                    }
                }
            }
        }
        
        freeifaddrs(ifaddr)
        return addresses
        
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
