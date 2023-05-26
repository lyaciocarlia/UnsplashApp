//
//  ForgotPasswordBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation


class ForgotPasswordBuilder {
    func build(coordinator: AuthetificationCoordinator) -> ForgotPasswordViewProtocol {
        let view = ForgotPasswordViewController()
        view.coordinator = coordinator
        let viewModel = ForgotPasswordViewModel()
        view.viewModel = viewModel
        return view
    }
}
