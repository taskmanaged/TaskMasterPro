import Foundation
import CryptoKit
import Crypto

class SecurityManager {
    static func hashPassword(_ password: String) -> (salt: String, hash: String)? {
        guard let saltData = try? Random.generate(byteCount: 16) else {
            return nil
        }
        let salt = saltData.base64EncodedString()
        guard let hashData = try? Bcrypt.hash(password, salt: saltData) else {
            return nil
        }
        let hash = hashData.base64EncodedString()
        return (salt: salt, hash: hash)
    }

    static func verifyPassword(_ password: String, salt: String, hash: String) -> Bool {
        guard let saltData = Data(base64Encoded: salt),
              let hashData = Data(base64Encoded: hash),
              let computedHashData = try? Bcrypt.hash(password, salt: saltData) else {
            return false
        }
        return computedHashData == hashData
    }
}