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
        
        Alamofire.request(LAGConstants.Webservice.PathInit, method: .post, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            switch response.result {
            case .success:
                print("Success: \(response.result.isSuccess)")
                if let result = response.result.value {
                    let JSONResult = result as! NSDictionary
                    print(JSONResult)
                    let AppTest = Mapper<AppModel>().map(JSONString: JSONResult)
                }
               
               // LAGWebService.sharedInstance.isAlive = (response.result == "SUCCESS")
               // onSuccess(response.result.value == "true")
            case .failure:
                  print("Success: \(response.result.isFailure)")
            }
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
        }
        
    }
    
    static public func cleanWebservice(){
        //LAGWebService.sharedInstance.userLogged = nil
    }

}
