//
//  BrowseViewProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

protocol BrowseViewProtocol: UIViewController {
    var viewModel: BrowseViewModelProtocol? { get set }
    var coordinator: BrowseCoordinatorProtocol? { get set }
}
