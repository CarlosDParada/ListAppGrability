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

    static func isServerAlive(onSuccess: (ResponseModel) -> Void, onError: (String?) -> Void) {
        
        Alamofire.request(.GET, LAGConstants.Webservice.PathInit, parameters: nil)
            .responseJSON { response in
                debugPrint(response)     // prints detailed description of all response properties
            
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            switch response.result {
            case .Success:
                //print("Success: \(response.result.isSuccess)")
                if let result = response.result.value {
                    let JSONResult = result as! NSDictionary
                    print(JSONResult)
                    let AppTest = Mapper<ResponseModel>().map(JSONResult)
                    let responseOK : ResponseModel!
                    responseOK = AppTest
                   // print("AppTest: \(AppTest?.author)")
                    onSuccess(responseOK)
                }
               
               // LAGWebService.sharedInstance.isAlive = (response.result == "SUCCESS")
               // onSuccess(response.result.value == "true")
            case .Failure:
                  print("Success: \(response.result.isFailure)")
            }
            debugPrint(response)
            
            if let json = response.result.value {
                //print("JSON: \(json)")
            }
        }
        
    }
    /*
    public func imageFromUrl(urlString: String) -> NSData {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                self.image = UIImage(data: data)
            }
        }
    }
    
    let request = NSMutableURLRequest(URL: NSURL(string: uniqueIamge.imageURL!)!)
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        print("Response: \(response)")
        print("Data: \(data)")
    })
    
    task.resume()
     
     
     var imageSet = Set<Image>()
     for uniqueIamge in images!{
     //  let heightI : Int? = Int(uniqueIamge.height!)
     if (uniqueIamge.imageURL != nil) {
     
     newImage.urlIamge = uniqueIamge.imageURL }
     if (uniqueIamge.height != nil) {
     newImage.heightImage = String(uniqueIamge.height) }
     
     
     
     
     CoreDataController().downloadImage(uniqueIamge.imageURL, callback: { (data) in
     
     let newImage = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: self.managedObjectContext) as! Image
     
     if (uniqueIamge.imageURL != nil) {
     
     newImage.urlIamge = uniqueIamge.imageURL }
     if (uniqueIamge.height != nil) {
     newImage.heightImage = String(uniqueIamge.height) }
     if( data != nil){
     newImage.dataImage = data }
     //self.temporaryImageArray = [(NSSet *)[[array objectAtIndex:0] images] allObjects]
     imageSet.insert(newImage)
     //  newItem.setValue(newImage, forKey: "image")
     //let imageChildren = newItem.mutableSetValueForKey("image")
     //imageChildren.addObject(newImage)
     
     })
     }
     newItem.setValue(imageSet, forKey: "image")
     
    //                let imageUrl = NSURL(fileURLWithPath: uniqueIamge.imageURL!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
    //                Alamofire.request(.GET, uniqueIamge.imageURL!, parameters: nil)
    //                   .responseImage(completionHandler: { (responseImage) in
    //
    //                    print("response : \(responseImage))")
    //                   })
 */
}
