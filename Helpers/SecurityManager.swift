import Foundation
import CryptoKit

class SecurityManager {
    static func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }

    static func verifyPassword(_ password: String, hash: String) -> Bool {
        return hashPassword(password) == hash
    }
}
