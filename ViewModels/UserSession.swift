import SwiftUI
import Combine
import CoreData
import CryptoKit

class UserSession: ObservableObject {
    @Published var currentUser: User?

    // Login function with a completion handler for success and error handling
    func login(email: String, password: String, context: NSManagedObjectContext, completion: @escaping (Bool, String?) -> Void) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)

        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                let hashedPassword = SHA256.hash(data: Data(password.utf8)).compactMap { String(format: "%02x", $0) }.joined()
                if user.password == hashedPassword {
                    currentUser = user
                    completion(true, nil) // Successfully logged in
                } else {
                    completion(false, "Invalid email or password.") // Invalid credentials
                }
            } else {
                completion(false, "Invalid email or password.") // Invalid credentials
            }
        } catch {
            completion(false, "An error occurred during login.") // Handle Core Data error
        }
    }

    // Logout function to clear the current user
    func logout() {
        currentUser = nil
    }
}
