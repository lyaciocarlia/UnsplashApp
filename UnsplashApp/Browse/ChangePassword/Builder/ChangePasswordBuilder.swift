//
//  ChangePasswordBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class ChangePasswordBuilder {
    func build(coordinator: BrowseCoordinator) -> ChangePasswordViewProtocol {
        let viewModel = ChangePasswordViewModel()
        let view = ChangePasswordViewController(viewModel: viewModel, coordinator: coordinator)
            return view
    }
}
