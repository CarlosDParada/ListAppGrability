//
//  Response+CoreDataProperties.swift
//  
//
//  Created by Carlos Parada on 6/10/16.
//
//

import Foundation
import CoreData


extension Response {

    override public class func fetchRequest() -> NSFetchRequest {
        return NSFetchRequest(entityName: "Response");
    }

    @NSManaged public var author: String?
    @NSManaged public var authorURL: String?
    @NSManaged public var updatedD: String?
    @NSManaged public var rights: String?
    @NSManaged public var tittle: String?
    @NSManaged public var iconURL: String?
    @NSManaged public var idResponse: String?
    @NSManaged public var link: NSSet?
    @NSManaged public var entry: NSSet?

}

// MARK: Generated accessors for link
extension Response {

    @objc(addLinkObject:)
    @NSManaged public func addToLink(value: Link)

    @objc(removeLinkObject:)
    @NSManaged public func removeFromLink(value: Link)

    @objc(addLink:)
    @NSManaged public func addToLink(values: NSSet)

    @objc(removeLink:)
    @NSManaged public func removeFromLink(values: NSSet)

}

// MARK: Generated accessors for entry
extension Response {

    @objc(addEntryObject:)
    @NSManaged public func addToEntry(value: Application)

    @objc(removeEntryObject:)
    @NSManaged public func removeFromEntry(value: Application)

    @objc(addEntry:)
    @NSManaged public func addToEntry(values: NSSet)

    @objc(removeEntry:)
    @NSManaged public func removeFromEntry(values: NSSet)

}
