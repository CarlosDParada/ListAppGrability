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
    override func viewDidLoad() {
        super.viewDidLoad()
        var responseWS : ResponseModel!
        // Do any additional setup after loading the view, typically from a nib.
        LAGWebService.isServerAlive({ (respondeJSON) in
  //          print("JSON: \(respondeJSON)")
            let aStr = String(format: "%@%@", "Response: \n\n", respondeJSON.toJSONString(true)!)
            self.textView1.text = aStr
            
            responseWS = respondeJSON
            let stateSaveAll: Bool = CoreDataController().saveAllDataInCoreData(responseWS)
            if stateSaveAll == true{
                /// User SAVE OK
               // let arrayLinksCD : Array = CoreDataController().getAllLink()
               // print("Link's in CoreData \(arrayLinksCD.count )")
                
                let arrayAppCD : Array = CoreDataController().getAllApps()
                print("Link's in CoreData \(arrayAppCD.count )")
                
                
                //self.performSegueWithIdentifier(AMSConstants.Menu.kSegueMenuLog, sender: nil)
            }else{
               // Error
            }
            
            }) { (error) in
                print("Error\(error) ")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

