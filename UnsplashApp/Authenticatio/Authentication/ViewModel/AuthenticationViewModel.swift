//
//  AuthenticationViewModel.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

class AuthenticationViewModel: AuthenticationViewModelProtocol {
    
    var isAuthenticated: Observable<Bool> = Observable(false)
    var wrongPassOrEmail: Observable<Bool> = Observable(false)
    var createAccError: Observable<String?> = Observable(" ")
    let service: AppServiceProtocol = AppService()
    
    func login(email: String, password: String) {
        if service.login(email: email, password: password)
        {
            self.isAuthenticated.value = true
        } else {
            wrongPassOrEmail.value = true
        }
    }
    
    func createAcc(email: String, password: String) {
        let user = User(email: email, password: password)
        let status = service.createAcc(user: user)
        
        if status == nil {
            self.isAuthenticated.value = true
        } else {
            self.createAccError.value = status!.localizedDescription
        }
    }
}
