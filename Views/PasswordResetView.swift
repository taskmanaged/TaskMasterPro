import SwiftUI
import CoreData

struct PasswordResetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var email: String = ""
    @State private var securityAnswer: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var user: User?
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSecurityQuestion = false

    var body: some View {
        VStack {
            Text("Reset Password")
                .font(.largeTitle)
                .padding()

            if !showSecurityQuestion {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: verifyEmail) {
                    Text("Next")
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .padding()
            } else {
                Text(user?.securityQuestion ?? "Security Question")
                    .padding()

                TextField("Answer", text: $securityAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("New Password", text: $newPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: resetPassword) {
                    Text("Reset Password")
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .padding()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func verifyEmail() {
        // Simulate email verification
        if email.isEmpty {
            alertMessage = "Email cannot be empty."
            showAlert = true
            return
        }

        // Fetch user from CoreData
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)

        do {
            let users = try viewContext.fetch(fetchRequest)
            if let fetchedUser = users.first {
                user = fetchedUser
                showSecurityQuestion = true
            } else {
                alertMessage = "Email not found."
                showAlert = true
            }
        } catch {
            alertMessage = "Failed to fetch user."
            showAlert = true
        }
    }

    private func resetPassword() {
        if newPassword != confirmPassword {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }

        // Simulate security answer verification and password reset
        if securityAnswer.isEmpty {
            alertMessage = "Security answer cannot be empty."
            showAlert = true
            return
        }

        if let user = user, user.securityAnswer == securityAnswer {
            user.password = newPassword
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                alertMessage = "Failed to reset password."
                showAlert = true
            }
        } else {
            alertMessage = "Incorrect security answer."
            showAlert = true
        }
    }
}
