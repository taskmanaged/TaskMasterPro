import SwiftUI
import CoreData

struct MainView: View {
    @EnvironmentObject var userSession: UserSession
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddTaskItem = false

    var body: some View {
        if let currentUser = userSession.currentUser {
            NavigationView {
                HStack {
                    SidebarView()
                    TaskItemListView()
                    TaskItemDetailView()
                }
                .navigationTitle("Welcome, \(currentUser.name ?? "Guest")")
            }
            .sheet(isPresented: $showingAddTaskItem) {
                TaskItemEditorView(taskItem: nil)
                    .environment(\.managedObjectContext, viewContext)
                    .environmentObject(userSession)
            }
            .onAppear {
                TimerManager.shared.startTimer(context: viewContext)
            }
            .onDisappear {
                TimerManager.shared.stopTimer()
            }
        } else {
            LoginView()
                .environmentObject(userSession)
        }
    }
}

struct TaskItemDetailView: View {
    var body: some View {
        VStack {
            Text("Select a Task Item to view details")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            AddTaskButton()
        }
    }
}

struct AddTaskButton: View {
    @Binding var showingAddTaskItem: Bool

    var body: some View {
        Button("Add New Task Item") {
            showingAddTaskItem.toggle()
        }
        .padding()
    }
}