//
//  NetworkCallController.swift
//  WhirlpoolWcloudBaseApp
//
//  Created by Vikram Naik on 08/09/17.
//  Copyright © 2017 whirlpool. All rights reserved.
//

import Foundation
import Alamofire


class NetworkCallController {
    
    
    public typealias StringProcessor = (String) -> String
    public typealias BinaryResultHandler = (_ succeeded: Bool) -> Void
    public typealias ResponseHandler = (AnyObject?, JSONResponse) -> Void
//    public typealias ResponseHandlerSeries = ([ResponseTouple]) -> Void
  
    public typealias JSONResult = Result<Any>
    public typealias JSONResponse = DataResponse<Any>
    
    class var sharedInstance :NetworkCallController {
        struct Singleton {
            static let instance = NetworkCallController(enviornment: "pord_stg")
        }
        
        return Singleton.instance
    }
    
    init(enviornment: String?) {
       
        //Todo
        if (enviornment == "pord_stg") {
//            NetworkStore
        }
       
    }

//    func hardProcessingWithString(input: String, completion: (result: String) -> Void) {
//        ...
//            completion("we finished!")
//    }
    func loginWith(email: String,password: String,completion:@escaping (_ result:DataResponse<Any>) -> Void ){
//        var params: Parameters! = [:]
        
        let params: [String: Any] = ["username": email, "password": password, "brand": NetworkStore.BrandName,"client_id":NetworkStore.ClientId,"client_secret":NetworkStore.ClientSecret,"grant_type":"password","language":"en"]
        
        Alamofire.request(NetworkStore.AppLogin, method: .post, parameters: params,
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                
//                guard response.result.error == nil else {
//                    // got an error in getting the data, need to handle it
//                    print("error calling POST on /todos/1")
//                    print(response.result.error!)
//                    return
//                }
//                
//                // make sure we got some JSON since that's what we expect
//                guard let json = response.result.value as? [String: Any] else {
//                    print("didn't get todo object as JSON from API")
////                    print("Error: \(response.result.error)")
//                    return
//                }
//                // get and print the title
//                guard let todoTitle = json["access_token"] as? String else {
//                    print("Could not get todo title from JSON")
//                    return
//                }
//                print("The title is: " + todoTitle)
                completion(response)
        }
    
}
}
