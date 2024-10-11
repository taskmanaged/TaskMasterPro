import SwiftUI

@main
struct TaskMasterProApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var userSession = UserSession() // Manage user session state

    init() {
        // Use DispatchSourceTimer for precise scheduling
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now(), repeating: 86400)
        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            do {
                try RecurrenceManager.shared.checkForRecurringTaskItems(context: persistenceController.container.viewContext)
            } catch {
                print("Error checking for recurring task items: \(error)")
            }
        }
        timer.resume()
    }

    var body: some Scene {
        WindowGroup {
            MainView() // Your main view
                .environment(\.managedObjectContext, persistenceController.container.viewContext) // Pass managed object context
                .environmentObject(userSession) // Pass the UserSession down the view hierarchy
        }
    }
}