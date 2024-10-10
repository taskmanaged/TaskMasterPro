import SwiftUI
import CoreData

struct UserManagementView: View {
    @EnvironmentObject var currentUser: User // Access current user for permission checks
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.name, ascending: true)],
        animation: .default)
    private var users: FetchedResults<User>

    @State private var showingAddUser = false

    var body: some View {
        List {
            ForEach(users) { user in
                Text(user.name ?? "Unnamed User")
            }
            .onDelete(perform: canDeleteUsers ? deleteUser : nil) // Enable delete if user has permission
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { showingAddUser.toggle() }) {
                    Label("Add User", systemImage: "plus")
                }
                .disabled(!canAddUsers) // Disable "Add User" if user lacks permission
            }
        }
        .sheet(isPresented: $showingAddUser) {
            UserEditorView()
                .environment(\.managedObjectContext, viewContext)
        }
        .navigationTitle("User Management")
    }

    // Check if the current user has permission to delete users
    private var canDeleteUsers: Bool {
        PermissionManager.shared.userHasPermission(currentUser, permissionName: "delete_user")
    }

    // Check if the current user has permission to add users
    private var canAddUsers: Bool {
        PermissionManager.shared.userHasPermission(currentUser, permissionName: "add_user")
    }

    // Delete users if permission is granted
    private func deleteUser(offsets: IndexSet) {
        withAnimation {
            offsets.map { users[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                // Handle error
            }
        }
    }
}
