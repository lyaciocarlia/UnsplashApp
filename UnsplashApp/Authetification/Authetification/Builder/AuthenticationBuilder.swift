//
//  AuthenticationBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class AuthenticationBuilder {
    
    func build(coordinator: AuthetificationCoordinator) -> AuthenticationViewProtocol {
        let view = AuthenticationViewController()
        view.coordinator = coordinator
        let viewModel = AuthenticationViewModel()
        view.viewModel = viewModel
        return view
    }
}
