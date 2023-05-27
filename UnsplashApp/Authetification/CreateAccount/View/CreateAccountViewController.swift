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
    
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    
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
