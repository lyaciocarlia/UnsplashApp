//
//  CreateAccountBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class CreateAccountBuilder {
    func build(coordinator: AuthenticationCoordinator) -> CreateAccountViewProtocol {
        let viewModel = AuthenticationViewModel()
        let view = CreateAccountViewController(viewModel: viewModel, coordinator: coordinator)
        return view
    }
}
