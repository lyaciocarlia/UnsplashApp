//
//  PictureDetailsBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class PictureDetailsBuilder {
    
    func build(coordinator: BrowseCoordinatorProtocol) -> PictureDetailsViewProtocol {
        let viewModel = PictureDetailsViewModel()
        let view = PictureDetailsViewController(viewModel: viewModel, coordinator: coordinator)
        return view
    }
}
