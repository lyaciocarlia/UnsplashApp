//
//  ForgotPasswordViewProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

protocol ForgotPasswordViewProtocol: UIViewController {
    var viewModel: ForgotPasswordViewModelProtocol? { get set }
    var coordinator: AuthetificationCoordinatorProtocol? { get set }
}
