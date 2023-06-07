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
        let browseImage = UIImage(systemName: "magnifyingglass")
        browseNavController.tabBarItem = UITabBarItem(title: "Browse", image: browseImage, tag: Screens.firstScreen)
        browseNavController.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        return browseNavController
    }
    
    func setupLikesVC() -> LikesViewProtocol {
        let likesVC = LikesBuilder().build(coordinator: self)
        let favoritesImage = UIImage(systemName: "heart")
        likesVC.tabBarItem = UITabBarItem(title: "Likes", image: favoritesImage, tag: Screens.firstScreen)
        likesVC.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        return likesVC
    }
    
    func setupSettingsVC() -> UINavigationController {
        let likesVC = SettingsBuilder().build(coordinator: self)
        settingsNavController = UINavigationController.init(rootViewController: likesVC)
        let settingsImage = UIImage(systemName: "gearshape")
        settingsNavController.tabBarItem = UITabBarItem(title: "Settings", image: settingsImage, tag: Screens.thirdScreen)
        settingsNavController.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        return settingsNavController
    }
    
    func openPictureDetails() {
        let detailVC = PictureDetailsBuilder().build(coordinator: self)
        browseNavController.navigationBar.isHidden = false
        browseNavController.pushViewController(detailVC, animated: true)
    }
    
    func openChangePasswordScreen() {
        let changePasswordVC = ChangePasswordBuilder().build(coordinator: self)
        settingsNavController.pushViewController(changePasswordVC, animated: true)
    }
}
