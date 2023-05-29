//
//  CreateAccountViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class CreateAccountViewController: UIViewController, CreateAccountViewProtocol {

    var viewModel: CreateAccountViewModelProtocol
    var coordinator: AuthenticationCoordinatorProtocol
    
    init(viewModel: CreateAccountViewModelProtocol, coordinator: AuthenticationCoordinatorProtocol) {
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
    
    @IBAction func confirm(_ sender: Any) {
        viewModel.authenticate(username: "", password: "")
    }
    
    func authenticationSuccessful() {
        coordinator.finishAuthentication()
    }

}
