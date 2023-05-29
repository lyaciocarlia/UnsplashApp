//
//  LoginViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {

    var viewModel: LoginViewModelProtocol
    var coordinator: AuthenticationCoordinatorProtocol
    
    init(viewModel: LoginViewModelProtocol, coordinator: AuthenticationCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.isAuthenticated.bind { [weak self] isAuthenticated in
            if isAuthenticated {
                self?.authenticationSuccessful()
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        viewModel.authenticate(username: "", password: "")
    }
    
    @IBAction func createAcc(_ sender: Any) {
        coordinator.openCreateAccScreen()
    }
    
    @IBAction func forgotPass(_ sender: Any) {
        coordinator.openForgotPasswordScreen()
    }
    
    func authenticationSuccessful() {
        coordinator.finishAuthentication()
    }
    
}
