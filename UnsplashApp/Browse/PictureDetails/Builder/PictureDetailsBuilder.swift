//
//  PictureDetailsBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

class PictureDetailsBuilder {
    
    func build(coordinator: BrowseCoordinatorProtocol, unsplashPhoto: UnsplashPhoto) -> PictureDetailsViewProtocol {
        let viewModel = PictureDetailsViewModel()
        let view = PictureDetailsViewController(viewModel: viewModel, coordinator: coordinator)
        view.unsplashPhoto = unsplashPhoto
        return view
    }
    
    func build(coordinator: BrowseCoordinatorProtocol, coreDataPhoto: CoreDataPhoto) -> PictureDetailsViewProtocol {
        let viewModel = PictureDetailsViewModel()
        let view = PictureDetailsViewController(viewModel: viewModel, coordinator: coordinator)
        view.coreDataPhoto = coreDataPhoto
        return view
    }
}
