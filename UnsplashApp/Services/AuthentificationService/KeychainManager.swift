//
//  KeychainManager.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 28.05.2023.
//

import Foundation

class KeychainManager {
    
    public enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
        case succes
    }
    
    static func saveAccount(user: User) throws {
        let query: [String: AnyObject] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrServer as String : "Unsplash.app" as AnyObject,
            kSecAttrAccount as String : user.email as AnyObject,
            kSecValueData as String : user.password as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
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
            kSecAttrServer as String : "Unsplash.app" as AnyObject,
            kSecAttrAccount as String : email as AnyObject,
            kSecReturnData as String : kCFBooleanTrue,
            kSecMatchLimit as String : kSecMatchLimit
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }
}
