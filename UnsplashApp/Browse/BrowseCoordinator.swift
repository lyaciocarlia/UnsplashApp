//
//  BrowseCoordinator.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

class BrowseCoordinator: BrowseCoordinatorProtocol {
    
    let navigationController = UINavigationController()
    var browseNavController = UINavigationController()
    var settingsNavController = UINavigationController()
    var likesNavController = UINavigationController()
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
        let browseImage = UIImage(systemName: Images.magnifyingglass)
        browseNavController.tabBarItem = UITabBarItem(title: ButtonsTitle.browseButton, image: browseImage, tag: Screens.firstScreen)
        browseNavController.tabBarItem.selectedImage = UIImage(systemName: Images.magnifyingglassFill)
        return browseNavController
    }
    
    func setupLikesVC() -> UINavigationController {
        let likesVC = LikesBuilder().build(coordinator: self)
        likesNavController = UINavigationController(rootViewController: likesVC)
        let favoritesImage = UIImage(systemName: Images.heart)
        likesNavController.tabBarItem = UITabBarItem(title: ButtonsTitle.likesButton, image: favoritesImage, tag: Screens.firstScreen)
        likesNavController.tabBarItem.selectedImage = UIImage(systemName: Images.heartFill)
        return likesNavController
    }
    
    func setupSettingsVC() -> UINavigationController {
        let likesVC = SettingsBuilder().build(coordinator: self)
        settingsNavController = UINavigationController.init(rootViewController: likesVC)
        let settingsImage = UIImage(systemName: Images.gearshape )
        settingsNavController.tabBarItem = UITabBarItem(title: ButtonsTitle.settingsButton, image: settingsImage, tag: Screens.thirdScreen)
        settingsNavController.tabBarItem.selectedImage = UIImage(systemName: Images.gearshapeFill)
        return settingsNavController
    }
    
    func openPictureDetails(unsplashPhoto: UnsplashPhoto) {
        let detailVC = PictureDetailsBuilder().build(coordinator: self, unsplashPhoto: unsplashPhoto)
        browseNavController.navigationBar.isHidden = true
        browseNavController.tabBarController?.tabBar.isHidden = true
        browseNavController.pushViewController(detailVC, animated: true)
    }
    
    func openPictureDetails(coreDataPhoto: CoreDataPhoto) {
        let detailVC = PictureDetailsBuilder().build(coordinator: self, coreDataPhoto: coreDataPhoto)
        likesNavController.navigationBar.isHidden = true
        likesNavController.tabBarController?.tabBar.isHidden = true
        likesNavController.pushViewController(detailVC, animated: true)
    }
    
    func goBackToBrowseScreen(controller: String) {
        switch controller {
        case Screen.browseScr:
            browseNavController.tabBarController?.tabBar.isHidden = false
            browseNavController.popViewController(animated: true)
        case Screen.likesScr:
            likesNavController.tabBarController?.tabBar.isHidden = false
            likesNavController.popViewController(animated: true)
        default:
            print("Errror to go back")
        }
    }
    
    func goBack() {
        likesNavController.popViewController(animated: true)
    }
    
    func openChangePasswordScreen() {
        let changePasswordVC = ChangePasswordBuilder().build(coordinator: self)
        settingsNavController.pushViewController(changePasswordVC, animated: true)
    }
    
    func goToAuthScreen() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        let targetVC = mainCoordinator.rootVC()
        targetVC.modalPresentationStyle = .fullScreen
        settingsNavController.show(targetVC, sender: self)
    }
}
