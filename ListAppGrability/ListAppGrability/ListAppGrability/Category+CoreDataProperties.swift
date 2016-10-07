//
//  Category+CoreDataProperties.swift
//  
//
//  Created by Carlos Parada on 6/10/16.
//
//

import Foundation
import CoreData



extension Category {

    @nonobjc public override class func fetchRequest() -> NSFetchRequest {
        return NSFetchRequest(entityName: "Category");
    }

    @NSManaged public var idCategory: String?
    @NSManaged public var termCategory: String?
    @NSManaged public var schemeCategory: String?
    @NSManaged public var nameCategory: String?
    @NSManaged public var application: Application?

}
