//
//  LoginBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class LoginBuilder {
    
    func build(coordinator: AuthenticationCoordinator) -> LoginViewProtocol {
        let viewModel = LoginViewModel()
        let view = LoginViewController(viewModel: viewModel, coordinator: coordinator)
        return view
    }
}
