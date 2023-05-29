//
//  ForgotPasswordViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController, ForgotPasswordViewProtocol {
    
    var viewModel: ForgotPasswordViewModelProtocol
    var coordinator: AuthenticationCoordinatorProtocol
    
    init(viewModel: ForgotPasswordViewModelProtocol, coordinator: AuthenticationCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func confirm(_ sender: Any) {
        coordinator.goBackToLoginScreen()
    }
    
}
