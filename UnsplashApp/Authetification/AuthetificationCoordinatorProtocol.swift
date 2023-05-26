//
//  AuthetificationCoordinatorProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

protocol AuthetificationCoordinatorProtocol {
    func finishAuthentication()
    func openLoginScreen()
    func openCreateAccScreen()
    func openForgotPasswordScreen()
    func goBackToLoginScreen()
}

