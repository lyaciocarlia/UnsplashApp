//
//  LoginViewProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

protocol LoginViewProtocol: UIViewController{
<<<<<<< HEAD:UnsplashApp/Authenticatio/Login/View/LoginViewProtocol.swift
        var viewModel: LoginViewModelProtocol { get set }
        var coordinator: AuthenticationCoordinatorProtocol { get set }
=======
        var viewModel: AuthenticationViewModel? { get set }
        var coordinator: AuthetificationCoordinatorProtocol? { get set }
>>>>>>> ba307ff (Use keychain):UnsplashApp/Authetification/Login/View/LoginViewProtocol.swift
}
