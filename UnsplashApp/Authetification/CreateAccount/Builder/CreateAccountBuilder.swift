//
//  CreateAccountBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class CreateAccountBuilder {
    
    func build(coordinator: AuthetificationCoordinator) -> CreateAccountViewProtocol {
        let view = CreateAccountViewController()
        view.coordinator = coordinator
        let viewModel = CreateAccountViewModel()
        view.viewModel = viewModel
        return view
    }
}
