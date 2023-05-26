//
//  LoginViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {

    var viewModel: LoginViewModelProtocol?
    var coordinator: AuthetificationCoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: Any) {
        viewModel?.authenticate(username: "", password: "")
        viewModel?.isAuthenticated.bind { [weak self] isAuthenticated in
            if isAuthenticated {
                self?.authenticationSuccessful()
            }
        }
    }
    
    @IBAction func createAcc(_ sender: Any) {
        coordinator?.openCreateAccScreen()
    }
    
    @IBAction func forgotPass(_ sender: Any) {
        coordinator?.openForgotPasswordScreen()
    }
    
    func authenticationSuccessful() {
        coordinator?.finishAuthentication()
    }
    
}
