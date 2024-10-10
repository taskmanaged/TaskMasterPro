import SwiftUI
import CoreData

struct RegistrationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var userSession: UserSession
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var securityQuestion: String = ""
    @State private var securityAnswer: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
                .padding()

            Form {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                SecureField("Confirm Password", text: $confirmPassword)
                TextField("Security Question", text: $securityQuestion)
                TextField("Security Answer", text: $securityAnswer)
            }
            .padding()

            Button(action: register) {
                Text("Create Account")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding()
            .disabled(!isFormValid())

            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Registration Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    // Validate form before enabling the "Create Account" button
    private func isFormValid() -> Bool {
        return !name.isEmpty &&
               isValidEmail(email) &&
               !password.isEmpty &&
               password == confirmPassword &&
               !securityQuestion.isEmpty &&
               !securityAnswer.isEmpty
    }

    // Validate email format
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    private func register() {
        // Registration logic here
    }
}
