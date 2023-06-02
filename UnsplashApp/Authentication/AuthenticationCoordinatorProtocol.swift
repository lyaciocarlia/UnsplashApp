//
//  AuthentificationCoordinatorProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

protocol AuthenticationCoordinatorProtocol {
    func finishAuthentication()
    func openLoginScreen()
    func openCreateAccScreen()
    func openForgotPasswordScreen()
    func goBackToLoginScreen()
}

