//
//  SettingsBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class SettingsBuilder {
    func build(coordinator: BrowseCoordinator) -> SettingsViewProtocol {
            let view = SettingsViewController()
            let viewModel = SettingsViewModel()
            view.coordinator = coordinator
            view.viewModel = viewModel
            return view
    }
}
