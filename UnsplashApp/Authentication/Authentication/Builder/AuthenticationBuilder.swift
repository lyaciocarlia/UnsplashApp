//
//  AuthenticationBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class AuthenticationBuilder {
    
    func build(coordinator: AuthenticationCoordinator) -> AuthenticationViewProtocol {
        let viewModel = AuthenticationViewModel()
        let view = AuthenticationViewController(viewModel: viewModel, coordinator: coordinator)
        return view
    }
}
