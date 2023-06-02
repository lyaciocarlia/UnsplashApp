//
//  AuthentificationService.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class AuthentitacionService: AuthenticationServiceProtocol {
    
    func checkForAcc() -> Bool {
        return KeychainManager.getAcc()
    }
    
    func login(email: String, password: String) -> Bool {
        let keychainPassword = String(decoding: getPassword(email: email), as: UTF8.self)
        if keychainPassword == password {
            return true
        } else { return false }
    }
    
    func createAcc(user: User) -> Error? {
        let status = saveAccount(user: user)
        return status
    }

    func saveAccount(user: User) -> Error? {
        do {
            try KeychainManager.saveAccount(user: user)
            return nil
        }
        catch {
            return error
        }
    }
    
    func getPassword(email: String) -> Data {
        guard let password = KeychainManager.getPassword(for: email) else { return Data() }
        return password
    }
}
