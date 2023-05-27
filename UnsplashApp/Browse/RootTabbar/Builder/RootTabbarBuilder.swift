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
        
        let viewModel = RootTabbarViewModel()
        let view = RootTabbarViewController(viewModel: viewModel,
                                            coordinator: coordinator ,
                                            browse: browse,
                                            likes: likes,
                                            settings: settings)
        return view
    }
}
