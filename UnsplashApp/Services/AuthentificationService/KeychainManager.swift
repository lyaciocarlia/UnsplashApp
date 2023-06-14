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
            kSecClass as String : kSecClassInternetPassword,
            kSecAttrServer as String : NSString(string: Constants.serviceName),
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
    
    static func getAccount() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: Constants.serviceName,
            kSecMatchLimit as String: kSecMatchLimitAll,
            kSecReturnAttributes as String: true
        ]
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess {
            if let items = result as? [[String: Any]] {
                return !items.isEmpty
            }
        }
        
        return false
    }
    
    static func getPassword(for email: String) -> Data? {
        let query: [String: AnyObject] = [
            kSecAttrServer as String : NSString(string: Constants.serviceName),
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : email as AnyObject,
            kSecReturnData as String : kCFBooleanTrue,
            kSecMatchLimit as String : kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        
        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }
    
    static func logOut() throws {
        let query: [String: Any] = [
            kSecAttrServer as String : NSString(string: Constants.serviceName),
            kSecClass as String : kSecClassInternetPassword
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess else {
            throw KeychainError.unknown (status)
        }
    }
    
    static func updateUserPassword(newPassword: String) -> Bool {
        let query: [String: Any] = [
               kSecAttrServer as String: Constants.serviceName,
               kSecClass as String: kSecClassInternetPassword,
           ]
           
           let attributes: [String: Any] = [
               kSecValueData as String: newPassword.data(using: .utf8)!,
           ]
           
           let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
           
           if status == errSecSuccess {
               // Password updated successfully
               return true
           } else {
               // Failed to update password
               return false
           }
    }
}

