//
//  ViewController.swift
//  ListAppGrability
//
//  Created by Carlos Parada on 5/10/16.
//  Copyright © 2016 carlosparada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView1: UITextView!
    var arrayAppCD : [Application]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var responseWS : ResponseModel!
        
        CoreDataController().deleteAllData("Application")
        CoreDataController().deleteAllData("Link")
        
        CoreDataController().deleteAllData("Response")
        
        LAGWebService.isServerAlive({ (respondeJSON) in
  //          print("JSON: \(respondeJSON)")
            let aStr = String(format: "%@%@", "Response: \n\n", respondeJSON.toJSONString(true)!)
            self.textView1.text = aStr
//            if responseJSON is 
            responseWS = respondeJSON
            
            let stateSaveAll: Bool = CoreDataController().saveAllDataInCoreData(responseWS)
            if stateSaveAll == true{

                self.arrayAppCD = CoreDataController().getAllApps()
                let arrayResponse : Array = CoreDataController().getResponse()
    
            
                print("Link's in CoreData \(self.arrayAppCD.count )")
                let aStr = String(format: "%@", "App in Core Data: \n\n \( self.arrayAppCD.count) \n\n\n Response in Core Data : \n\n \(arrayResponse.count) \n\n\n Date Last Response : \n\n \(self.formatterDate(arrayResponse.last!.updatedD))")
                self.textView1.text = aStr
                
                self.performSegueWithIdentifier(LAGConstants.View.segueHome, sender: nil)
                
            }else{
               // Error Save in CoreData
            }
            
            }) { (error) in
                // Check in CoreData
                print("Error\(error) ")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == LAGConstants.View.segueHome) {
            let homeViewController = segue.destinationViewController as! LAGHomeViewController
           
            homeViewController.arrayAppCD = self.arrayAppCD
            
            
            
        }
    }

    func formatterDate(dateString : String?) -> String {
        //2016-10-03T13:20:51-07:00
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ'"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "COT")
        dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)
        dateFormatter.locale = NSLocale(localeIdentifier: "es_CO")
     //   dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        let date = dateFormatter.dateFromString(dateString!)
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        
        let dateOk = formatter.stringFromDate(date!)
        return dateOk
    }


}

