//
//  TaskItem+CoreDataProperties.swift
//  TaskMasterPro
//
//  Created by Joshua Shirreffs on 10/9/24.
//
//

import Foundation
import CoreData
import TaskMasterProModels // Import the module where User and TaskItem are defined

extension TaskMasterProModels.TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskMasterProModels.TaskItem> {
        return NSFetchRequest<TaskMasterProModels.TaskItem>(entityName: "TaskItem")
    }

    @NSManaged public var customFields: NSObject?
    @NSManaged public var details: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isRecurring: Bool
    @NSManaged public var priority: String?
    @NSManaged public var recurrenceRule: String?
    @NSManaged public var status: String?
    @NSManaged public var timeEstimate: Double
    @NSManaged public var timeSpent: Double
    @NSManaged public var title: String?
    @NSManaged public var assignedTo: TaskMasterProModels.User? // Use fully qualified name

}

extension TaskMasterProModels.TaskItem : Identifiable {

}

//
//  User+CoreDataProperties.swift
//  TaskMasterPro
//
//  Created by Joshua Shirreffs on 10/9/24.
//
//

import Foundation
import CoreData
import TaskMasterProModels // Import the module where User and TaskItem are defined

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var tasks: NSSet? // Use fully qualified name if needed

    // Add convenience methods to manage the tasks relationship
    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: TaskMasterProModels.TaskItem) // Use fully qualified name

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: TaskMasterProModels.TaskItem) // Use fully qualified name

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension User : Identifiable {

}
