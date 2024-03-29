//
//  AuthentificationServiceProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

protocol AuthenticationServiceProtocol {
    func login(email: String, password: String) -> Bool
    func createAccount(user: User) -> Error?
    func checkForAccount() -> Bool
}
