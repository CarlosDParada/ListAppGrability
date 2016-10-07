//
//  Image+CoreDataProperties.swift
//  
//
//  Created by Carlos Parada on 6/10/16.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public override class func fetchRequest() -> NSFetchRequest {
        return NSFetchRequest(entityName: "Image");
    }

    @NSManaged public var heightImage: String?
    @NSManaged public var urlIamge: String?
    @NSManaged public var dataImage: NSData?
    @NSManaged public var application: Application?

}
