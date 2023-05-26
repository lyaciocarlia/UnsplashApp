//
//  AuthenticationProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

protocol AuthenticationViewProtocol: UIViewController {
    var viewModel: AuthenticationViewModelProtocol? { get set }
    var coordinator: AuthetificationCoordinatorProtocol? { get set }
}
