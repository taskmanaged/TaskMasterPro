import SwiftUI

struct ReportsView: View {
    @State private var selectedReportType: String = "TaskItems by Status"
    let reportTypes = ["TaskItems by Status", "TaskItems by User", "Time Spent per TaskItem"]

    var body: some View {
        VStack {
            Picker("Select Report", selection: $selectedReportType) {
                ForEach(reportTypes, id: \.self) { type in
                    Text(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Placeholder for report content
            ReportContentView(reportType: selectedReportType)
        }
        .navigationTitle("Reports")
    }
}

struct ReportContentView: View {
    let reportType: String

    var body: some View {
        Text("Displaying report for \(reportType)")
            .padding()
    }
}
