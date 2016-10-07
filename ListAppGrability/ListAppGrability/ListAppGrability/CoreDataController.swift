//
//  CoreDataController.swift
//  ListAppGrability
//
//  Created by Carlos Parada on 6/10/16.
//  Copyright © 2016 carlosparada. All rights reserved.
//

import UIKit
import CoreData
// Retreive the managedObjectContext from AppDelegate

public class CoreDataController: NSObject {
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    // MARK: - USER
    
    func saveLink(rel: String, type: String , href : String) -> Bool {
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Link", inManagedObjectContext: managedObjectContext) as! Link
        newItem.rel = rel
        newItem.type = type
        newItem.href = href
        do {
            try newItem.managedObjectContext?.save()
            return true
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return false
        }
        
    }
    
    func saveAllDataInCoreData(responseWB : ResponseModel)-> Bool{
        if let response : ResponseModel = responseWB{
            print("response \n \(response) ")
            for linkWS in response.link! {
                CoreDataController().saveLink( linkWS.rel! , type: linkWS.type! , href: linkWS.href! )
            }
            
            return true
        }else{
            return false
        }
    }
    
    func getAllLink() -> Array<Link> {
        
        var listLinkCD : Array = [Link]()
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest()
        // Create Entity Description
        let entityDescription =  NSEntityDescription.entityForName("Link",
                                                                   inManagedObjectContext: self.managedObjectContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            for managedObject in result{
                listLinkCD.append(managedObject as! Link)
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return listLinkCD
    }
}
