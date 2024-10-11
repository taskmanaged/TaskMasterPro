import Foundation
import CryptoKit

class SecurityManager {
    static func hashPassword(_ password: String) -> String {
        let salt = generateSalt()
        let data = Data((salt + password).utf8)
        let hash = SHA256.hash(data: data)
        let hashString = hash.map { String(format: "%02x", $0) }.joined()
        return salt + ":" + hashString
    }

    static func verifyPassword(_ password: String, hash: String) -> Bool {
        let components = hash.split(separator: ":")
        guard components.count == 2 else { return false }
        let salt = String(components[0])
        let storedHash = String(components[1])
        let data = Data((salt + password).utf8)
        let hashToVerify = SHA256.hash(data: data)
        let hashString = hashToVerify.map { String(format: "%02x", $0) }.joined()
        return hashString == storedHash
    }

    private static func generateSalt() -> String {
        let saltLength = 16
        var salt = Data(count: saltLength)
        let result = salt.withUnsafeMutableBytes { SecRandomCopyBytes(kSecRandomDefault, saltLength, $0.baseAddress!) }
        precondition(result == errSecSuccess, "Failed to generate random bytes")
        return salt.map { String(format: "%02x", $0) }.joined()
    }
}
