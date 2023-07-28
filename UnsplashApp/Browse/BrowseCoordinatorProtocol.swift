//
//  BrowseCoordinatorProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

protocol BrowseCoordinatorProtocol {
    func openPictureDetails(unsplashPhoto: UnsplashPhoto)
    func openChangePasswordScreen()
    func openBrowseModule() -> UIViewController
    func goBackToBrowseScreen(controller: String)
    func openPictureDetails(coreDataPhoto: CoreDataPhoto) 
}
