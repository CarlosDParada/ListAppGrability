//
//  LAGWebservice.swift
//  ListAppGrability
//
//  Created by Carlos Parada on 5/10/16.
//  Copyright © 2016 carlosparada. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public class LAGWebService: NSObject {

    public static let sharedInstance = {
        return LAGWebService()
    }()
    public var isAlive: Bool = false

    static public func isServerAlive(onSuccess: (Bool) -> Void, onError: (String?) -> Void) {
        
        Alamofire.request(.GET, LAGConstants.Webservice.PathInit, parameters: nil)
            .responseJSON { response in
                debugPrint(response)     // prints detailed description of all response properties
            
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            switch response.result {
            case .Success:
                print("Success: \(response.result.isSuccess)")
                if let result = response.result.value {
                    let JSONResult = result as! NSDictionary
                    print(JSONResult)
                    let AppTest = Mapper<ResponseModel>().map(JSONResult)
                    print("AppTest: \(AppTest?.author)")
                }
               
               // LAGWebService.sharedInstance.isAlive = (response.result == "SUCCESS")
               // onSuccess(response.result.value == "true")
            case .Failure:
                  print("Success: \(response.result.isFailure)")
            }
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
        }
        
    }
    
    static public func getAllDataWebService(onSuccess: (Bool) -> Void, onError: (String?) -> Void){
        
        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                debugPrint(response)     // prints detailed description of all response properties
                
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    let JSONResult = JSON as! NSDictionary
                    print(JSONResult)
                    let AppTest = Mapper<AppModel>().map(JSONResult)

                }
        }
    }

}
