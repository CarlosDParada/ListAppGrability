//
//  ViewController.swift
//  ListAppGrability
//
//  Created by Carlos Parada on 5/10/16.
//  Copyright © 2016 carlosparada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var responseWS : ResponseModel!
        // Do any additional setup after loading the view, typically from a nib.
        LAGWebService.isServerAlive({ (respondeJSON) in
            print("JSON: \(respondeJSON)")
            responseWS = respondeJSON
            
            
            }) { (error) in
                print("Error\(error) ")
        }
        CoreDataController().saveAllDataInCoreData(ResponseModel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

