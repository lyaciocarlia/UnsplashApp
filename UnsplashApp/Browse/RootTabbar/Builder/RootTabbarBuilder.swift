//
//  RootTabbarBuilder.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

class RootTabbarBuilder {
    
    func build(coordinator: BrowseCoordinator,
               browse: UINavigationController,
               likes: LikesViewProtocol,
               settings: UINavigationController) -> RootTabbarProtocol {
        
        let view = RootTabbarViewController(browse: browse, likes: likes, settings: settings)
        let viewModel = RootTabbarViewModel()
        view.coordinator = coordinator
        view.viewModel = viewModel
        return view
    }
}
