import SwiftUI

struct CustomFieldEditorView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var key: String = ""
    @State private var value: String = ""

    var onSave: (CustomField) -> Void

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Field Name", text: $key)
                    TextField("Field Value", text: $value)
                }
                .frame(minWidth: 300, minHeight: 150) // Adjust the minimum frame size for better form presentation
            }
            .navigationTitle("Add Custom Field")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newField = CustomField(key: key, value: value)
                        onSave(newField)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(key.isEmpty || value.isEmpty) // Disable "Save" button if fields are empty
                }
            }
        }
    }
}
