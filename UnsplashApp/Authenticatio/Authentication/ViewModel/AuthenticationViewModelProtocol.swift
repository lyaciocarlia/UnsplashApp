//
//  AuthenticationViewModelProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

protocol AuthenticationViewModelProtocol {
    var isAuthenticated: Observable <Bool> { get }
    var isValidEmail: Observable<Bool> { get }
    func login(email: String, password: String)
    func validateEmail(_ email: String)
    func validatePassword(_ password: String)
    func comparePasswords(target password: String, with secondPassword: String)
}
