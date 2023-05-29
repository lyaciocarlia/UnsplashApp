//
//  MainCoordinator.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, UINavigationControllerDelegate {
    
    var navigationController = UINavigationController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func rootVC() -> UIViewController {
        let authCoordinator = AuthenticationCoordinator(navigationController: navigationController)
        return authCoordinator.rootVC()
    }
    
    func goToBrowseScreen() {
        let vc = BrowseCoordinator()
        navigationController.setViewControllers([vc.openBrowseModule()], animated: true)
    }
}
