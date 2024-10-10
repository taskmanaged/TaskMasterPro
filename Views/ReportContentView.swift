import SwiftUI

struct ReportContentView: View {
    var reportType: String

    var body: some View {
        switch reportType {
        case "TaskItems by Status":
            TaskItemsByStatusReport()
        case "TaskItems by User":
            TaskItemsByUserReport()
        case "Time Spent per TaskItem":
            TimeSpentPerTaskItemReport()
        default:
            Text("Select a report type.")
        }
    }
}

struct TaskItemsByStatusReport: View {
    var body: some View {
        Text("Task Items by Status Report")
    }
}

struct TaskItemsByUserReport: View {
    var body: some View {
        Text("Task Items by User Report")
    }
}

struct TimeSpentPerTaskItemReport: View {
    var body: some View {
        Text("Time Spent per Task Item Report")
    }
}
