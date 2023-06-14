//
//  AuthenticationCoordinator.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

class AuthenticationCoordinator: AuthenticationCoordinatorProtocol {
    
    private var navigationController: UINavigationController
    private let authenticationVCBuilder = AuthenticationBuilder()
    private let loginVCBuilder = LoginBuilder()
    private let createAccVCBuilder = CreateAccountBuilder()
    private let forgotPasswordVCBuilder = ForgotPasswordBuilder()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func rootVC() -> UIViewController {
        navigationController = UINavigationController.init(rootViewController: authenticationVCBuilder.build(coordinator: self))
        return navigationController
    }
    
    func openLoginScreen() {
        navigationController.pushViewController(loginVCBuilder.build(coordinator: self), animated: true)
    }
    
    func openCreateAccScreen() {
        navigationController.pushViewController(createAccVCBuilder.build(coordinator: self), animated: true)
    }
    
    func openForgotPasswordScreen() {
        navigationController.pushViewController(forgotPasswordVCBuilder.build(coordinator: self), animated: true)
    }
    
    func goBackToLoginScreen() {
        navigationController.popViewController(animated: true)
    }
    
    func finishAuthentication() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.goToBrowseScreen()
    }
    
}
