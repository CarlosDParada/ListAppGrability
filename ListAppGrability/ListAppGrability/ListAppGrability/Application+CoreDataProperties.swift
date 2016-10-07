//
//  Application+CoreDataProperties.swift
//  
//
//  Created by Carlos Parada on 6/10/16.
//
//

import Foundation
import CoreData


extension Application {

    @nonobjc public override class func fetchRequest() -> NSFetchRequest {
        return NSFetchRequest(entityName: "Application");
    }

    @NSManaged public var name: String?
    @NSManaged public var summary: String?
    @NSManaged public var price: Float
    @NSManaged public var currency: String?
    @NSManaged public var contentType: String?
    @NSManaged public var rights: String?
    @NSManaged public var title: String?
    @NSManaged public var linkHref: String?
    @NSManaged public var idURL: String?
    @NSManaged public var idID: String?
    @NSManaged public var idBundle: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var category: Category?
    @NSManaged public var artist: Artist?
    @NSManaged public var image: NSSet?
    @NSManaged public var responseJSON: Response?

}

// MARK: Generated accessors for image
extension Application {

    @objc(addImageObject:)
    @NSManaged public func addToImage( value: Image)

    @objc(removeImageObject:)
    @NSManaged public func removeFromImage(value: Image)
    
    @objc(addImage:)
    @NSManaged public func addToImage(values: NSSet)

    @objc(removeImage:)
    @NSManaged public func removeFromImage(values: NSSet)

}
