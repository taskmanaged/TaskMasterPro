import SwiftUI

struct UserEditorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var role: String = "Employee"

    let roles = ["Developer", "Admin", "Manager", "Employee"]

    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Picker("Role", selection: $role) {
                ForEach(roles, id: \.self) {
                    Text($0)
                }
            }
            Button(action: saveUser) {
                Text("Save")
            }
        }
        .navigationTitle("New User")
    }

    private func saveUser() {
        let newUser = User(context: viewContext)
        newUser.id = UUID()
        newUser.name = name
        newUser.email = email
        newUser.password = password
        // Assign role (you may need to fetch the Role entity)

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            // Handle error
        }
    }
}
