//
//  AppService.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class AppService: AppServiceProtocol {
    let authenticationService: AuthenticationServiceProtocol = AuthentitacionService()
    
    func login(email: String, password: String) -> Bool {
        return authenticationService.login(email: email, password: password )
    }
    
    func createAcc(user: User) -> Error? {
        let status = authenticationService.createAcc(user: user)
        return status
    }
    
    func checkForAcc() -> Bool {
        return authenticationService.checkForAcc()
    }
}
