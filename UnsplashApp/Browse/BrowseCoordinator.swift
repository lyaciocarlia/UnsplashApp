//
//  BrowseCoordinator.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

class BrowseCoordinator: BrowseCoordinatorProtocol {
   
    var browseNavController = UINavigationController()
    var settingsNavController = UINavigationController()
    let rootTabbar = RootTabbarBuilder()
    
    func openBrowseModule() -> UIViewController {
        let viewModel = RootTabbarViewModel()
        let tabBar = rootTabbar.build(coordinator: self, browse: setupBrowseVC(), likes: setupLikesVC(), settings: setupSettingsVC())
        tabBar.viewModel = viewModel
        return tabBar
    }
    
    func setupBrowseVC() -> UINavigationController {
        let browseVC = BrowseBuilder().build(coordinator: self)
        browseNavController = UINavigationController.init(rootViewController: browseVC)
        browseNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return browseNavController
    }
    
    func setupLikesVC() -> LikesViewProtocol {
        let likesVC = LikesBuilder().build(coordinator: self)
        likesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return likesVC
    }
    
    func setupSettingsVC() -> UINavigationController {
        let likesVC = SettingsBuilder().build(coordinator: self)
        settingsNavController = UINavigationController.init(rootViewController: likesVC)
        settingsNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks , tag: 2)
        return settingsNavController
    }
    
    func openPictureDetails() {
        let detailVC = PictureDetailsBuilder().build(coordinator: self)
        browseNavController.pushViewController(detailVC, animated: true)
    }
    
    func openChangePasswordScreen() {
        let changePasswordVC = ChangePasswordBuilder().build(coordinator: self)
        settingsNavController.pushViewController(changePasswordVC, animated: true)
    }
}
