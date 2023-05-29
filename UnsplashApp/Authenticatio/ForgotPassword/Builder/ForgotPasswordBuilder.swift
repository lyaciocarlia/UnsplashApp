//
//  ForgotPasswordBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation


class ForgotPasswordBuilder {
    func build(coordinator: AuthenticationCoordinator) -> ForgotPasswordViewProtocol {
        let viewModel = ForgotPasswordViewModel()
        let view = ForgotPasswordViewController(viewModel: viewModel, coordinator: coordinator)
        return view
    }
}
