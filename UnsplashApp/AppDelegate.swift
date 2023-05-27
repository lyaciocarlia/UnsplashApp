//
//  AppDelegate.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        UINavigationBar.appearance().tintColor = .label
        
        let navController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navController)
        
        window?.rootViewController = mainCoordinator.rootVC()
        window?.makeKeyAndVisible()
        
        return true
    }
}

