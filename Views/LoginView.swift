import SwiftUI

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var userSession: UserSession

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegistration = false
    @State private var showPasswordReset = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Text("TaskItemMaster Pro")
                .font(.largeTitle)
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.leading, .trailing])

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.leading, .trailing])

            Button(action: login) {
                Text("Login")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding()

            HStack {
                Button(action: { showRegistration.toggle() }) {
                    Text("Register")
                }
                .sheet(isPresented: $showRegistration) {
                    RegistrationView()
                        .environment(\.managedObjectContext, viewContext)
                        .environmentObject(userSession)
                }

                Spacer()

                Button(action: { showPasswordReset.toggle() }) {
                    Text("Forgot Password?")
                }
                .sheet(isPresented: $showPasswordReset) {
                    PasswordResetView()
                }
            }
            .padding([.leading, .trailing])
        }
        .padding()
    }
}
