//
//  PictureDetailsBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class PictureDetailsBuilder {
    
    func build(coordinator: BrowseCoordinatorProtocol) -> PictureDetailsViewProtocol {
        let view = PictureDetailsViewController()
        let viewModel = PictureDetailsViewModel()
        view.coordinator = coordinator
        view.viewModel = viewModel
        return view
    }
}
