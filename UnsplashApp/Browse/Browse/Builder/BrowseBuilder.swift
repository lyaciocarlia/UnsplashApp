//
//  BrowseBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class BrowseBuilder {
    func build(coordinator: BrowseCoordinator) -> BrowseViewProtocol {
        let viewModel = BrowseViewModel()
        let view = BrowseViewController(viewModel: viewModel, coordinator: coordinator)
        
        return view
    }
}
