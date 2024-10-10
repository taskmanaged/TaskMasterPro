//
//  Permission+CoreDataProperties.swift
//  TaskMasterPro
//
//  Created by Joshua Shirreffs on 10/9/24.
//
//

import Foundation
import CoreData


extension Permission {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Permission> {
        return NSFetchRequest<Permission>(entityName: "Permission")
    }

    @NSManaged public var name: String?
    @NSManaged public var role: NSSet?

}

// MARK: Generated accessors for role
extension Permission {

    @objc(addRoleObject:)
    @NSManaged public func addToRole(_ value: Role)

    @objc(removeRoleObject:)
    @NSManaged public func removeFromRole(_ value: Role)

    @objc(addRole:)
    @NSManaged public func addToRole(_ values: NSSet)

    @objc(removeRole:)
    @NSManaged public func removeFromRole(_ values: NSSet)

}

extension Permission : Identifiable {

}
