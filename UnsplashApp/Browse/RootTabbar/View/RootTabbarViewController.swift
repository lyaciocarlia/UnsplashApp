//
//  RootTabbarViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class RootTabbarViewController: UITabBarController, RootTabbarProtocol {

    var viewModel: RootTabbarViewModelProtocol?
    var coordinator: BrowseCoordinatorProtocol?
    
    var browse: UINavigationController
    var likes: LikesViewProtocol
    var settings: UINavigationController
    
    init(viewModel: RootTabbarViewModelProtocol? = nil,
         coordinator: BrowseCoordinatorProtocol? = nil,
         browse: UINavigationController,
         likes: LikesViewProtocol,
         settings: UINavigationController) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.browse = browse
        self.likes = likes
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .black
        self.viewControllers = [browse, likes, settings]
    }

}
