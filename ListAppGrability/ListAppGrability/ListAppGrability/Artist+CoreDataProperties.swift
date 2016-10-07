//
//  Artist+CoreDataProperties.swift
//  
//
//  Created by Carlos Parada on 6/10/16.
//
//

import Foundation
import CoreData

extension Artist {

    @nonobjc public override class func fetchRequest() -> NSFetchRequest {
        return NSFetchRequest(entityName: "Artist");
    }

    @NSManaged public var nameArtist: String?
    @NSManaged public var urlArtist: String?
    @NSManaged public var application: Application?

}
