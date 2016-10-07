//
//  Link+CoreDataProperties.swift
//  
//
//  Created by Carlos Parada on 6/10/16.
//
//

import Foundation
import CoreData


extension Link {

    @nonobjc public override class func fetchRequest() -> NSFetchRequest {
        return NSFetchRequest(entityName: "Link");
    }

    @NSManaged public var rel: String?
    @NSManaged public var type: String?
    @NSManaged public var href: String?
    @NSManaged public var responseJSON: Response?

}
