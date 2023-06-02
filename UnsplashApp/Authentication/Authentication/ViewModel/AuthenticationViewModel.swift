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
    var isValidEmail: Observable<Bool> = Observable(false)
    var isValidPassword: Observable<Bool> = Observable(false)
    var isErrorMessageHiden: Observable<Bool> = Observable(true)
    var isPasswordEquals: Observable<Bool> = Observable(false)
    var createAccError: Observable<String?> = Observable(" ")
    let service: AppServiceProtocol = AppService()
    
    func checkForAuth() {
        isAuthenticated.value = service.checkForAcc()
    }
    
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
    
    func validateEmail(_ email: String) {
        let emailRegex = Constants.emailRegex
        self.isValidEmail.value = email.hasSuffix(emailRegex)
    }
    
    func validatePassword(_ password: String) {
        self.isValidPassword.value = password.count > Constants.minimPasswordSize
        self.isErrorMessageHiden.value = password.count > Constants.minimPasswordSize 
    }
    
    func comparePasswords(target password: String, with secondPassword: String) {
        if secondPassword == password {
            self.isPasswordEquals.value = true
        } else {
            self.isPasswordEquals.value = false
        }
    }
}
