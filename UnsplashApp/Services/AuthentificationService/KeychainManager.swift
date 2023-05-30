//
//  KeychainManager.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 28.05.2023.
//

import Foundation
import Security

class KeychainManager {
    
    public enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    static func saveAccount(user: User) throws {
        let query = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : user.email as AnyObject,
            kSecValueData as String : user.password.data(using: .utf8) as AnyObject
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateEntry
        }
        guard status == errSecSuccess else {
            throw KeychainError.unknown (status)
        }
    }
    
    static func getPassword(for email: String) -> Data? {
        let query: [String: AnyObject] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : email as AnyObject,
            kSecReturnData as String : kCFBooleanTrue,
            kSecMatchLimit as String : kSecMatchLimitOne
        ]
    
        var result: AnyObject?
        
        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }
}
