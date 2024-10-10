import SwiftUI

@main
struct TaskMasterProApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var userSession = UserSession() // Manage user session state

    // Optional recurring TaskItem check (uncomment if you need this)
    init() {
        // Ensure the Timer is scheduled correctly
        Timer.scheduledTimer(withTimeInterval: 86400, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            RecurrenceManager.shared.checkForRecurringTaskItems(context: persistenceController.container.viewContext)
        }
    }

    var body: some Scene {
        WindowGroup {
            MainView() // Your main view
                .environment(\.managedObjectContext, persistenceController.container.viewContext) // Pass managed object context
                .environmentObject(userSession) // Pass the UserSession down the view hierarchy
        }
    }
}
