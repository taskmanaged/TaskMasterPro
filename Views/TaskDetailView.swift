import SwiftUI

// Define User class
class User: ObservableObject {
    @Published var name: String
    
    init(name: String) {
        self.name = name
    }
}

// Ensure TaskItem conforms to ObservableObject
class TaskItem: ObservableObject {
    @Published var title: String = "Untitled TaskItem"
    @Published var status: String = "Unknown"
    @Published var priority: String = "Normal"
    @Published var assignedTo: User? = nil
    @Published var dueDate: Date? = nil
    @Published var details: String = "No Details"
}

struct TaskItemDetailView: View {
    @ObservedObject var taskItem: TaskItem

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(taskItem.title)
                .font(.largeTitle)
            Text("Status: \(taskItem.status)")
            Text("Priority: \(taskItem.priority)")
            Text("Assigned To: \(taskItem.assignedTo?.name ?? "Unassigned")")
            Text("Due Date: \(taskItem.dueDate?.description(with: .current) ?? "No Due Date")")
            Text("Details:")
                .font(.headline)
            Text(taskItem.details)
                .padding()
            
            // Add TimeTrackingView for tracking TaskItem time
            TimeTrackingView(taskItem: taskItem)
                .padding()

            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink(destination: TaskItemEditorView(taskItem: taskItem)) {
                    Text("Edit")
                }
            }
        }
        .navigationTitle("TaskItem Details")
    }
}
