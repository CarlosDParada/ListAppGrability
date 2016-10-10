//
//  CoreDataController.swift
//  ListAppGrability
//
//  Created by Carlos Parada on 6/10/16.
//  Copyright © 2016 carlosparada. All rights reserved.
//

import UIKit
import CoreData
import AlamofireImage
import Alamofire

// Retreive the managedObjectContext from AppDelegate

public class CoreDataController: NSObject {
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    //MARK:  All Data
    
    func saveAllDataInCoreData(responseWB : ResponseModel)-> Bool{
        var linkSet = Set<Link>()
        var entrySet = Set<Application>()
        
        if let response : ResponseModel = responseWB{
            //   print("response \n \(response) ")
            let responseCD = NSEntityDescription.insertNewObjectForEntityForName("Response", inManagedObjectContext: managedObjectContext) as! Response
            
            if (response.author != nil) {
                responseCD.author = response.author }
            if (response.authorURL != nil) {
                responseCD.authorURL = response.authorURL }
            if (response.iconURL != nil) {
                responseCD.iconURL = response.iconURL }
            if (response.idResponse != nil) {
                responseCD.idResponse = response.idResponse }
            if (response.rights != nil) {
                responseCD.rights = response.rights }
            if (response.tittle != nil) {
                responseCD.tittle = response.tittle }
            if (response.updated != nil) {
                responseCD.updatedD = response.updated }
            if (response.entry != nil) {
                for uniqueEntry in response.entry!{
                    let entryM : Application = CoreDataController().formatterApplication(uniqueEntry)
                    entrySet.insert(entryM)
                }
                responseCD.setValue(entrySet, forKey: "entry")
            }
            if (response.link != nil) {
                for uniqueLink in response.link!{
                    let linkM : Link = CoreDataController().formatterLink(uniqueLink)
                    linkSet.insert(linkM)
                }
                responseCD.setValue(linkSet, forKey: "link")
            }
            do {
                try responseCD.managedObjectContext?.save()
                return true
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
                return false
            }
        }
    }
    
    //MARK: Application
    func saveApplication (name: String? , images: [ImageModel]? , summary : String? , price : Float? , currency: String? , contentType: String? , rights: String? , title : String? , linkHref : String? , idUrl : String? ,  idID : String? , idBundle : String? , artist : ArtistModel? , category :CategoryModel? , releaseDate: String? )-> Bool{
        
        
        var imageSet = Set<Image>()
        
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
                imageSet.insert(newImage)
            }
            newItem.setValue(imageSet, forKey: "image")
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
    //MARK: Application
    func formatterApplication (application: AppModel) -> Application {
        
        //(application: ApplicationModel?) -> Application
        
        var imageSet = Set<Image>()
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Application", inManagedObjectContext: managedObjectContext) as! Application
        
        if (application.name != nil) {
            newItem.name = application.name }
        if (application.images != nil) {
            for uniqueIamge in application.images!{
                //  let heightI : Int? = Int(uniqueIamge.height!)
                let newImage = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: self.managedObjectContext) as! Image
                if (uniqueIamge.imageURL != nil) {
                    
                    newImage.urlIamge = uniqueIamge.imageURL }
                if (uniqueIamge.height != nil) {
                    newImage.heightImage = String(uniqueIamge.height) }
                imageSet.insert(newImage)
            }
            newItem.setValue(imageSet, forKey: "image")
        }
        if (application.summary != nil) {
            newItem.summary = application.summary }
        if (application.price  != nil) {
            newItem.price = application.price! }
        if (application.currency != nil) {
            newItem.currency = application.currency }
        if (application.contentType != nil) {
            newItem.contentType = application.contentType }
        if (application.rights != nil) {
            newItem.rights = application.rights }
        if (application.title != nil) {
            newItem.title = application.title }
        if (application.linkHref != nil) {
            newItem.linkHref = application.linkHref }
        if (application.idUrl != nil) {
            newItem.idURL = application.idUrl }
        if (application.idId != nil) {
            newItem.idID = application.idId }
        if (application.idBundle != nil) {
            newItem.idBundle = application.idBundle }
        if (application.artist != nil) {
            let newArtist = NSEntityDescription.insertNewObjectForEntityForName("Artist", inManagedObjectContext: managedObjectContext) as! Artist
            if (application.artist?.nameArtist != nil) {
                newArtist.nameArtist = application.artist?.nameArtist }
            if (application.artist?.urlArtist != nil) {
                newArtist.urlArtist = application.artist?.urlArtist }
            newItem.setValue(newArtist, forKey: "artist")
            // let artistChildren = newItem.mutableSetValueForKey("artist")
            // artistChildren.addObject(newArtist)
        }
        if (application.category != nil) {
            let newCategory = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            if (application.category!.idCategory != nil) {
                newCategory.idCategory = application.category!.idCategory }
            if (application.category!.nameCategory != nil) {
                newCategory.nameCategory = application.category!.nameCategory }
            if (application.category!.scheme != nil) {
                newCategory.schemeCategory = application.category!.scheme }
            if (application.category!.term != nil) {
                newCategory.termCategory = application.category!.term }
            newItem.setValue(newCategory, forKey: "category")
            //  let artistChildren = newItem.mutableSetValueForKey("category")
            // artistChildren.addObject(newCategory)
        }
        if (application.releaseDate != nil) {
            newItem.releaseDate = application.releaseDate }
        do {
            //try newItem.managedObjectContext?.save()
            return newItem
        }
    }
    //MARK : - Download
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
    func saveLinkCD(rel: String?, type: String? , href : String?) -> Bool {
        
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
    func formatterLink(link: LinkModel?) -> Link {
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Link", inManagedObjectContext: managedObjectContext) as! Link
        
        if (link?.rel != nil) {
            newItem.rel = link?.rel }
        if (link?.type != nil) {
            newItem.type = link?.type }
        if( link?.href != nil){
            newItem.href = link?.href }
        do {
            // try newItem.managedObjectContext?.save()
            return newItem
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
    
    //MARK:  GetResponse
    func getResponse() -> Array<Response> {
        
        var listResponse : Array = [Response]()
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest()
        // Create Entity Description
        let entityDescription =  NSEntityDescription.entityForName("Response",
                                                                   inManagedObjectContext: self.managedObjectContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            for managedObject in result{
                listResponse.append(managedObject as! Response)
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return listResponse
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
    //MARK:  GetApplications
    func getAllCategory() -> Array<Category> {
        
        var listcCategoryCD : Array = [Category]()
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest()
        // Create Entity Description
        let entityDescription =  NSEntityDescription.entityForName("Category",
                                                                   inManagedObjectContext: self.managedObjectContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            for managedObject in result{
                listcCategoryCD.append(managedObject as! Category)
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return listcCategoryCD
    }
    //MARK: DeleteAll
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
}
