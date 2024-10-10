//
//  Role+CoreDataProperties.swift
//  TaskMasterPro
//
//  Created by Joshua Shirreffs on 10/9/24.
//
//

import Foundation
import CoreData


extension Role {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Role> {
        return NSFetchRequest<Role>(entityName: "Role")
    }

    @NSManaged public var name: String?
    @NSManaged public var permissions: NSSet?
    @NSManaged public var users: User?

}

// MARK: Generated accessors for permissions
extension Role {

    @objc(addPermissionsObject:)
    @NSManaged public func addToPermissions(_ value: Permission)

    @objc(removePermissionsObject:)
    @NSManaged public func removeFromPermissions(_ value: Permission)

    @objc(addPermissions:)
    @NSManaged public func addToPermissions(_ values: NSSet)

    @objc(removePermissions:)
    @NSManaged public func removeFromPermissions(_ values: NSSet)

}

extension Role : Identifiable {

}
