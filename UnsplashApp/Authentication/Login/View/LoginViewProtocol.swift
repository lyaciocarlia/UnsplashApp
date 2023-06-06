//
//  LoginViewProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

protocol LoginViewProtocol: UIViewController{
        var viewModel: AuthenticationViewModel { get set }
        var coordinator: AuthenticationCoordinatorProtocol { get set }
}
