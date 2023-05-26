//
//  ChangePasswordBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class ChangePasswordBuilder {
    func build(coordinator: BrowseCoordinator) -> ChangePasswordViewProtocol {
            let view = ChangePasswordViewController()
            let viewModel = ChangePasswordViewModel()
            view.coordinator = coordinator
            view.viewModel = viewModel
            return view
    }
}
