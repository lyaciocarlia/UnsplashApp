//
//  LikesBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class LikesBuilder {
    func build(coordinator: BrowseCoordinator) -> LikesViewProtocol {
            let view = LikesViewController()
            let viewModel = LikesViewModel()
            view.coordinator = coordinator
            view.viewModel = viewModel
            return view
    }
}
