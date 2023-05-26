//
//  AuthenticationViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class AuthenticationViewController: UIViewController, AuthenticationViewProtocol {
    
    var viewModel: AuthenticationViewModelProtocol?
    var coordinator: AuthetificationCoordinatorProtocol?
    
    @IBAction func createAcc(_ sender: Any) {
        coordinator?.openCreateAccScreen()
    }
    
    @IBAction func login(_ sender: Any) {
        coordinator?.openLoginScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.isAuthenticated.bind { [weak self] isAuthenticated in
            if isAuthenticated {
                self?.authenticationSuccessful()
            }
        }
    }
    
    func authenticationSuccessful() {
        coordinator?.finishAuthentication()
    }
}

