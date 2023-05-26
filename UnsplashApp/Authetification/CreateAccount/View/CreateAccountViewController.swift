//
//  CreateAccountViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class CreateAccountViewController: UIViewController, CreateAccountViewProtocol {

    var viewModel: CreateAccountViewModelProtocol?
    var coordinator: AuthetificationCoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func confirm(_ sender: Any) {
        viewModel?.authenticate(username: "", password: "")
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
