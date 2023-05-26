//
//  BrowseBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class BrowseBuilder {
    func build(coordinator: BrowseCoordinator) -> BrowseViewProtocol {
        let view = BrowseViewController()
        let viewModel = BrowseViewModel()
        view.coordinator = coordinator
        view.viewModel = viewModel
        return view
    }
}
