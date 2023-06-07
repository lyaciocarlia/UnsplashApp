//
//  RootTabbarViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class RootTabbarViewController: UITabBarController, RootTabbarProtocol {
    
    var viewModel: RootTabbarViewModelProtocol
    var coordinator: BrowseCoordinatorProtocol    
    var browse: UINavigationController
    var likes: LikesViewProtocol
    var settings: UINavigationController
    
    init(viewModel: RootTabbarViewModelProtocol,
         coordinator: BrowseCoordinatorProtocol,
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let lineColor = UIColor.lightGray
        let lineWidth: CGFloat = 0.5
        let lineLayer = CALayer()
        lineLayer.backgroundColor = lineColor.cgColor
        lineLayer.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: lineWidth)
        tabBar.layer.addSublayer(lineLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .black
        self.viewControllers = [browse, likes, settings]
    }
    
}
