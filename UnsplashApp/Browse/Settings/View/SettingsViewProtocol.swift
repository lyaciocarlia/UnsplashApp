//
//  SettingsViewControllerProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

protocol SettingsViewProtocol: UIViewController {
    var viewModel: SettingsViewModelProtocol { get set }
    var coordinator: BrowseCoordinatorProtocol { get set }
}
