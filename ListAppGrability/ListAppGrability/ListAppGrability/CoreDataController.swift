//
//  CoreDataController.swift
//  ListAppGrability
//
//  Created by Carlos Parada on 6/10/16.
//  Copyright © 2016 carlosparada. All rights reserved.
//

import UIKit
import CoreData

import Alamofire
import AlamofireImage

// Retreive the managedObjectContext from AppDelegate

public class CoreDataController: NSObject {
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    //MARK:  All Data
    
    func saveAllDataInCoreData(responseWB : ResponseModel)-> Bool{
        if let response : ResponseModel = responseWB{
         //   print("response \n \(response) ")
            for linkWS in response.link! {
               // print(" \(linkWS.rel!)")
                CoreDataController().saveLink( linkWS.rel  , type: linkWS.type , href: linkWS.href  )
            }
            for uniqueApp in response.entry!{
                print("App :  \(uniqueApp.name!)")
                let stateSaveApp: Bool = CoreDataController().saveApplication(uniqueApp.name, images: uniqueApp.images, summary: uniqueApp.summary, price: uniqueApp.price, currency: uniqueApp.currency, contentType: uniqueApp.contentType, rights: uniqueApp.rights, title: uniqueApp.title, linkHref: uniqueApp.linkHref, idUrl: uniqueApp.idUrl, idID: uniqueApp.idId, idBundle: uniqueApp.idBundle, artist: uniqueApp.artist, category: uniqueApp.category, releaseDate: uniqueApp.releaseDate)
                if stateSaveApp == true {
                    print("Ok Save \(uniqueApp.name)")
                }else{
                    print("Error in \(uniqueApp.name)")
                }
            }
            
            return true
        }else{
            return false
        }
    }
    
    //MARK: Application
    func saveApplication (name: String? , images: [ImageModel]? , summary : String? , price : Float? , currency: String? , contentType: String? , rights: String? , title : String? , linkHref : String? , idUrl : String? ,  idID : String? , idBundle : String? , artist : ArtistModel? , category :CategoryModel? , releaseDate: String? )-> Bool{
    
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Application", inManagedObjectContext: managedObjectContext) as! Application
        
        if (name != nil) {
            newItem.name = name }
        if (images != nil) {
            
            for uniqueIamge in images!{
              //  let heightI : Int? = Int(uniqueIamge.height!)
                let newImage = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: self.managedObjectContext) as! Image
                if (uniqueIamge.imageURL != nil) {
                    
                    newImage.urlIamge = uniqueIamge.imageURL }
                if (uniqueIamge.height != nil) {
                    newImage.heightImage = String(uniqueIamge.height) }

            }
            
        }
        if (summary != nil) {
            newItem.summary = summary }
        if (price  != nil) {
            newItem.price = price! }
        if (currency != nil) {
            newItem.currency = currency }
        if (contentType != nil) {
            newItem.contentType = contentType }
        if (rights != nil) {
            newItem.rights = rights }
        if (title != nil) {
            newItem.title = title }
        if (linkHref != nil) {
            newItem.linkHref = linkHref }
        if (idUrl != nil) {
            newItem.idURL = idUrl }
        if (idID != nil) {
            newItem.idID = idID }
        if (idBundle != nil) {
            newItem.idBundle = idBundle }
        if (artist != nil) {
            let newArtist = NSEntityDescription.insertNewObjectForEntityForName("Artist", inManagedObjectContext: managedObjectContext) as! Artist
            if (artist?.nameArtist != nil) {
                newArtist.nameArtist = artist?.nameArtist }
            if (artist?.urlArtist != nil) {
                newArtist.urlArtist = artist?.urlArtist }
            newItem.setValue(newArtist, forKey: "artist")
           // let artistChildren = newItem.mutableSetValueForKey("artist")
           // artistChildren.addObject(newArtist)
        }
        if (category != nil) {
            let newCategory = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            if (category!.idCategory != nil) {
                newCategory.idCategory = category!.idCategory }
            if (category!.nameCategory != nil) {
                newCategory.nameCategory = category!.nameCategory }
            if (category!.scheme != nil) {
                newCategory.schemeCategory = category!.scheme }
            if (category!.term != nil) {
                newCategory.termCategory = category!.term }
            newItem.setValue(newCategory, forKey: "category")
          //  let artistChildren = newItem.mutableSetValueForKey("category")
           // artistChildren.addObject(newCategory)
        }
        if (releaseDate != nil) {
            newItem.releaseDate = releaseDate }
        do {
            try newItem.managedObjectContext?.save()
            return true
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return false
        }
    
    }
    
    func downloadImage(imageUrl: String?, callback: (( data : NSData? ) -> Void)) {
        
        let url = NSURL(fileURLWithPath: imageUrl!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        //print("URL Image \(url)")
    
        Alamofire.request(.GET, url).responseImage { response in
            if let image = response.result.value {
//                let image : UIImage = UIImage(data: data , scale:  1.0)!
                let imageData: NSData = UIImagePNGRepresentation(image)!
                callback(data: imageData)
                print("image downloaded: \(image)")
            }
        }
    }
    //MARK:  Link
    func saveLink(rel: String?, type: String? , href : String?) -> Bool {
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Link", inManagedObjectContext: managedObjectContext) as! Link
        
        if (rel != nil) {
            newItem.rel = rel }
        if (type != nil) {
            newItem.type = type }
        if( href != nil){
            newItem.href = href }
        do {
            try newItem.managedObjectContext?.save()
            return true
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return false
        }
        
    }
    //MARK:  Image
    
    //  self.saveImage(uniqueIamge.imageURL, heightImage: String(uniqueIamge.height) , dataImage: data)
    
    func saveImage(urlImage: String?, heightImage: String? , dataImage : NSData?) -> Bool {
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: managedObjectContext) as! Image
        
        if (urlImage != nil) {
            newItem.urlIamge = urlImage }
        if (heightImage != nil) {
            newItem.heightImage = heightImage }
        if( dataImage != nil){
            newItem.dataImage = dataImage }
        do {
            try newItem.managedObjectContext?.save()
            return true
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return false
        }
        
    }
    //MARK:  Category
    func saveCategory(idCategory: String?, nameCategory: String? , schemeCategory : String? , termCategory : String?) -> Bool {
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
        
        if (idCategory != nil) {
            newItem.idCategory = idCategory }
        if (nameCategory != nil) {
            newItem.nameCategory = nameCategory }
        if( schemeCategory != nil){
            newItem.schemeCategory = schemeCategory }
        if (termCategory != nil) {
                newItem.termCategory = termCategory }

        do {
            try newItem.managedObjectContext?.save()
            return true
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return false
        }
        
    }
    //MARK:  Artist
    func saveArtist(nameArtist: String?, urlArtist: String? ) -> Bool {
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Artist", inManagedObjectContext: managedObjectContext) as! Artist
        
        if (nameArtist != nil) {
            newItem.nameArtist = nameArtist }
        if (urlArtist != nil) {
            newItem.urlArtist = urlArtist }
               do {
            try newItem.managedObjectContext?.save()
            return true
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return false
        }
        
    }
  
    //MARK:  Get
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
    //MARK:  GetApplications
    func getAllApps() -> Array<Application> {
        
        var listLinkCD : Array = [Application]()
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest()
        // Create Entity Description
        let entityDescription =  NSEntityDescription.entityForName("Application",
                                                                   inManagedObjectContext: self.managedObjectContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            for managedObject in result{
                listLinkCD.append(managedObject as! Application)
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return listLinkCD
    }
}
