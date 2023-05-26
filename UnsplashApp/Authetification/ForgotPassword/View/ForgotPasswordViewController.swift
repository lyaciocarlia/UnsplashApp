//
//  ForgotPasswordViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController, ForgotPasswordViewProtocol {
    
    var viewModel: ForgotPasswordViewModelProtocol?
    var coordinator: AuthetificationCoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func confirm(_ sender: Any) {
        coordinator?.goBackToLoginScreen()
    }
    
}
