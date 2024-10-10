import SwiftUI

struct TimeTrackingView: View {
    @ObservedObject var TaskItem: TaskItem
    @Environment(\.managedObjectContext) private var viewContext

    @State private var timerActive = false
    @State private var startTime: Date?

    var body: some View {
        VStack {
            Text("Time Spent: \(TaskItem.timeSpent, specifier: "%.2f") hours")
            Button(timerActive ? "Stop Timer" : "Start Timer") {
                toggleTimer()
            }
        }
    }

    private func toggleTimer() {
        timerActive.toggle()
        if timerActive {
            startTime = Date()
        } else if let start = startTime {
            let timeInterval = Date().timeIntervalSince(start)
            TaskItem.timeSpent += timeInterval / 3600 // Convert seconds to hours
            do {
                try viewContext.save()
            } catch {
                // Handle error
            }
        }
    }
}
