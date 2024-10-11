import Foundation
import CoreData

public extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var securityAnswer: String?
    @NSManaged public var securityQuestion: String?
    @NSManaged public var role: Role?
    @NSManaged public var taskAssigned: NSSet?
}

// MARK: Generated accessors for taskAssigned
public extension User {

    @objc(addTaskAssignedObject:)
    @NSManaged public func addToTaskAssigned(_ value: TaskItem)

    @objc(removeTaskAssignedObject:)
    @NSManaged public func removeFromTaskAssigned(_ value: TaskItem)

    @objc(addTaskAssigned:)
    @NSManaged public func addToTaskAssigned(_ values: NSSet)

    @objc(removeTaskAssigned:)
    @NSManaged public func removeFromTaskAssigned(_ values: NSSet)
}

extension User : Identifiable {
}