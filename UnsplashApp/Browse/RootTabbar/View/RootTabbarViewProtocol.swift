//
//  RootTabbarViewProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

protocol RootTabbarProtocol: UIViewController {
    var viewModel: RootTabbarViewModelProtocol { get set }
    var coordinator: BrowseCoordinatorProtocol { get set }
}
