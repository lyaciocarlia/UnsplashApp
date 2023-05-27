//
//  LikesBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class LikesBuilder {
    func build(coordinator: BrowseCoordinator) -> LikesViewProtocol {
        let viewModel = LikesViewModel()
        let view = LikesViewController(viewModel: viewModel, coordinator: coordinator)
        return view
    }
}
