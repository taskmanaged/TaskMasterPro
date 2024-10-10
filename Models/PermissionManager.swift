import Foundation
import CoreData

class PermissionManager {
    static let shared = PermissionManager()

    func userHasPermission(_ user: User, permissionName: String) -> Bool {
        guard let role = user.role as? Role else { return false }
        guard let permissions = role.permissions as? Set<Permission> else { return false }
        return permissions.contains { $0.name == permissionName }
    }
}
