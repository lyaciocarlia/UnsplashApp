//
//  BrowseCoordinatorProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

protocol BrowseCoordinatorProtocol {
    func openPictureDetails()
    func openChangePasswordScreen()
    func openBrowseModule() -> UIViewController
}
