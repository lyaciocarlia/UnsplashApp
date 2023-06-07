//
//  LikesViewControllerProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

protocol LikesViewProtocol: UIViewController {
    var viewModel: LikesViewModelProtocol { get set }
    var coordinator: BrowseCoordinatorProtocol { get set }
}
