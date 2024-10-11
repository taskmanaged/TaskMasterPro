import Foundation
import CoreData

extension TaskMasterPro.User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskMasterPro.User> {
        return NSFetchRequest<TaskMasterPro.User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var securityAnswer: String?
    @NSManaged public var securityQuestion: String?
    @NSManaged public var role: TaskMasterPro.Role?
    @NSManaged public var taskAssigned: NSSet?
}

// MARK: Generated accessors for taskAssigned
extension TaskMasterPro.User {

    @objc(addTaskAssignedObject:)
    @NSManaged public func addToTaskAssigned(_ value: TaskMasterPro.TaskItem)

    @objc(removeTaskAssignedObject:)
    @NSManaged public func removeFromTaskAssigned(_ value: TaskMasterPro.TaskItem)

    @objc(addTaskAssigned:)
    @NSManaged public func addToTaskAssigned(_ values: NSSet)

    @objc(removeTaskAssigned:)
    @NSManaged public func removeFromTaskAssigned(_ values: NSSet)
}

extension TaskMasterPro.User : Identifiable {
}