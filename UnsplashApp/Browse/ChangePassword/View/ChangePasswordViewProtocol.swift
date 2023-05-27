//
//  ChangePasswordViewProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

protocol ChangePasswordViewProtocol: UIViewController {
    var viewModel: ChangePasswordViewModelProtocol { get set }
    var coordinator: BrowseCoordinatorProtocol { get set }
}
