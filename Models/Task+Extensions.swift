import Foundation
import CoreData

extension TaskItem {
    var customFieldsArray: [CustomField] {
        get {
            if let data = customFields as? Data {
                let decoder = JSONDecoder()
                if let fields = try? decoder.decode([CustomField].self, from: data) {
                    return fields
                }
            }
            return []
        }
        set {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(newValue) {
                customFields = data as NSData
            }
        }
    }
}
