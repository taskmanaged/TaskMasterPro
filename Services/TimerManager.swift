import Foundation
import CoreData

class TimerManager {
    static let shared = TimerManager()
    private var timer: Timer?

    func startTimer(context: NSManagedObjectContext) {
        // Invalidate the existing timer if it exists
        stopTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: 86400, repeats: true) { _ in
            RecurrenceManager.shared.checkForRecurringTaskItems(context: context)
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
