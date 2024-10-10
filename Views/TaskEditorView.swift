import SwiftUI
import CoreData

struct TaskItemEditorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userSession: UserSession

    @StateObject var taskItem: TaskItem
    var isNew: Bool

    @State private var title: String = ""
    @State private var details: String = ""
    @State private var status: String = "Pending"
    @State private var priority: String = "Normal"
    @State private var dueDate: Date = Date()
    @State private var customFields: [CustomField] = []
    @State private var showingAddCustomField = false

    let statuses = ["Pending", "In Progress", "Completed"]
    let priorities = ["Low", "Normal", "High", "Critical"]

    // Custom initializer to optionally set the TaskItem and isNew properties
    init(taskItem: TaskItem? = nil) {
        if let existingTaskItem = taskItem {
            _taskItem = StateObject(wrappedValue: existingTaskItem)
            isNew = false
        } else {
            let context = PersistenceController.shared.container.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "TaskItem", in: context)!
            let newTaskItem = TaskItem(entity: entity, insertInto: context)
            newTaskItem.id = UUID()
            _taskItem = StateObject(wrappedValue: newTaskItem)
            isNew = true
        }

        // Set default state values for new or existing TaskItems
        if let taskItem = taskItem {
            _title = State(initialValue: taskItem.title ?? "")
            _details = State(initialValue: taskItem.details ?? "")
            _status = State(initialValue: taskItem.status ?? "Pending")
            _priority = State(initialValue: taskItem.priority ?? "Normal")
            _dueDate = State(initialValue: taskItem.dueDate ?? Date())
            _customFields = State(initialValue: taskItem.customFieldsArray)
        }
    }

    var body: some View {
        Form {
            // TaskItem Information Section
            Section(header: Text("Task Item Information")) {
                TextField("Title", text: $title)
                Picker("Status", selection: $status) {
                    ForEach(statuses, id: \.self) {
                        Text($0)
                    }
                }
                Picker("Priority", selection: $priority) {
                    ForEach(priorities, id: \.self) {
                        Text($0)
                    }
                }
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }

            // TaskItem Details Section
            Section(header: Text("Details")) {
                TextEditor(text: $details)
            }

            // Custom Fields Section
            Section(header: Text("Custom Fields")) {
                List {
                    ForEach(customFields) { field in
                        HStack {
                            Text(field.key)
                                .fontWeight(.bold)
                            Spacer()
                            Text(field.value)
                        }
                    }
                    .onDelete(perform: deleteCustomField)
                }
                Button(action: { showingAddCustomField.toggle() }) {
                    Label("Add Custom Field", systemImage: "plus")
                }
            }

            // Save Button
            Button(action: saveTaskItem) {
                Text("Save")
            }
            .disabled(!canEditTask()) // Disable if user lacks permission
        }
        .onAppear(perform: loadTaskItem)
        .navigationTitle(isNew ? "New Task Item" : "Edit Task Item")
        .sheet(isPresented: $showingAddCustomField) {
            CustomFieldEditorView { newField in
                customFields.append(newField)
            }
        }
    }

    // Load the TaskItem's existing data if editing
    private func loadTaskItem() {
        if !isNew {
            title = taskItem.title ?? ""
            details = taskItem.details ?? ""
            status = taskItem.status ?? "Pending"
            priority = taskItem.priority ?? "Normal"
            dueDate = taskItem.dueDate ?? Date()
            customFields = taskItem.customFieldsArray
        }
    }

    // Save or update the TaskItem in Core Data
    private func saveTaskItem() {
        taskItem.title = title
        taskItem.details = details
        taskItem.status = status
        taskItem.priority = priority
        taskItem.dueDate = dueDate
        taskItem.customFieldsArray = customFields // Assuming customFieldsArray is a transformable attribute

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error saving TaskItem: \(error.localizedDescription)")
        }
    }

    // Check if the user has permission to edit the task item
    private func canEditTask() -> Bool {
        guard let currentUser = userSession.currentUser else {
            return false // If no user is logged in, return false
        }
        return PermissionManager.shared.userHasPermission(currentUser, permissionName: "edit_taskItem")
    }

    // Delete a custom field
    private func deleteCustomField(at offsets: IndexSet) {
        customFields.remove(atOffsets: offsets)
    }
}
