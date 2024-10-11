import CoreData
import os.log

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "TaskMasterProModel")
        if inMemory {
            if let description = container.persistentStoreDescriptions.first {
                description.url = URL(fileURLWithPath: "/dev/null")
            } else {
                os_log("No persistent store descriptions found.", log: OSLog.default, type: .error)
                return
            }
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                os_log("Unresolved error %{PUBLIC}@, %{PUBLIC}@", log: OSLog.default, type: .error, error.localizedDescription, error.userInfo)
                // Implement error recovery here, such as retrying the load or notifying the user.
            } else {
                DispatchQueue.main.async {
                    // Notify the UI or any observers that the store has been loaded successfully.
                    NotificationCenter.default.post(name: .NSPersistentStoreCoordinatorStoresDidChange, object: self.container.persistentStoreCoordinator)
                }
            }
        })
    }
}