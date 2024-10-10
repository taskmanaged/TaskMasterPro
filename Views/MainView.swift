import SwiftUI
import CoreData

struct MainView: View {
    @EnvironmentObject var userSession: UserSession // Access the user session
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddTaskItem = false

    var body: some View {
        if let currentUser = userSession.currentUser { // Check if a user is logged in
            NavigationView {
                HStack {
                    SidebarView() // Sidebar for navigation
                    TaskItemListView() // Main TaskItem list view
                    VStack {
                        Text("Select a Task Item to view details")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)

                        // Button to add a new Task Item
                        Button("Add New Task Item") {
                            showingAddTaskItem.toggle()
                        }
                        .padding()
                    }
                }
                .navigationTitle("Welcome, \(currentUser.name ?? "Guest")") // Display the user's name
            }
            .sheet(isPresented: $showingAddTaskItem) {
                TaskItemEditorView(taskItem: nil) // Pass nil to create a new TaskItem
                    .environment(\.managedObjectContext, viewContext)
                    .environmentObject(userSession) // Pass the user session to TaskItemEditorView
            }
            .onAppear {
                TimerManager.shared.startTimer(context: viewContext) // Start the timer when the view appears
            }
            .onDisappear {
                TimerManager.shared.stopTimer() // Stop the timer when the view disappears
            }
        } else {
            LoginView() // Display the login view when no user is logged in
                .environmentObject(userSession) // Ensure LoginView also has access to UserSession
        }
    }
}

