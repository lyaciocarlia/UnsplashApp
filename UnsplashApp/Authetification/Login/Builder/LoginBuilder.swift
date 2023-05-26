//
//  LoginBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class LoginBuilder {
    
    func build(coordinator: AuthetificationCoordinator) -> LoginViewProtocol {
        let view = LoginViewController()
        view.coordinator = coordinator
        let viewModel = LoginViewModel()
        view.viewModel = viewModel
        return view
    }
}
