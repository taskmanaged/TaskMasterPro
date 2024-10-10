//
//  TaskItem+CoreDataProperties.swift
//  TaskMasterPro
//
//  Created by Joshua Shirreffs on 10/9/24.
//
//

import Foundation
import CoreData


extension TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem")
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
    @NSManaged public var assignedTo: User?

}

extension TaskItem : Identifiable {

}
