//
//  SettingsBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class SettingsBuilder {
    func build(coordinator: BrowseCoordinator) -> SettingsViewProtocol {
        let viewModel = SettingsViewModel()
        let view = SettingsViewController(viewModel: viewModel, coordinator: coordinator)
        return view
    }
}
