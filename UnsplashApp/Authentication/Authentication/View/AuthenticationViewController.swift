//
//  AuthenticationViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class AuthenticationViewController: UIViewController, AuthenticationViewProtocol {
    
    var viewModel: AuthenticationViewModelProtocol
    var coordinator: AuthenticationCoordinatorProtocol
    
    init(viewModel: AuthenticationViewModelProtocol, coordinator: AuthenticationCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func createAcc(_ sender: Any) {
        coordinator.openCreateAccScreen()
    }
    
    @IBAction func login(_ sender: Any) {
        coordinator.openLoginScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.isAuthenticated.bind { [weak self] isAuthenticated in
            if isAuthenticated {
                self?.authenticationSuccessful()
            }
        }
        viewModel.checkForAuthentication()
    }
    
    func authenticationSuccessful() {
        coordinator.finishAuthentication()
    }
}
