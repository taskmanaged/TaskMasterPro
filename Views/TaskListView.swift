import SwiftUI
import CoreData

struct TaskItemListView: View {
    @EnvironmentObject var userSession: UserSession
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)],
        animation: .default)
    private var taskItems: FetchedResults<TaskItem>

    @State private var showingAddTaskItem = false

    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(taskItems, id: \.self) { taskItem in
                    VStack(alignment: .leading) {
                        Text(taskItem.title ?? "Untitled TaskItem")
                            .font(.headline)
                        Text(taskItem.status ?? "No Status")
                            .font(.subheadline)
                    }
                }
                .onDelete { offsets in
                    if canDeleteTaskItems {
                        deleteTaskItems(offsets: offsets)
                    }
                } // Only allow deletion if user has permission
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { showingAddTaskItem.toggle() }) {
                    Label("Add TaskItem", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddTaskItem) {
            TaskItemEditorView() // Create a new TaskItem
                .environment(\.managedObjectContext, viewContext)
                .environmentObject(userSession)
        }
        .navigationTitle("TaskItems")
    }

    // Permission check function for deletion
    private var canDeleteTaskItems: Bool {
        guard let currentUser = userSession.currentUser else {
            return false
        }
        return currentUser.hasPermission(.deleteTaskItems)
    }

    private func deleteTaskItems(offsets: IndexSet) {
        guard canDeleteTaskItems else {
            // Handle the case where the user does not have permission
            print("User does not have permission to delete task items.")
            return
        }

        withAnimation {
            offsets.map { taskItems[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                // Handle the Core Data error
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
