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
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var topLabelConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifcations()
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
    
    private func registerKeyboardNotifcations() {

        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyaboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        topLabelConstraint.constant -= 30
        UIView.animate(withDuration: 0.3) {
               self.view.layoutIfNeeded()
           }
    }

    @objc private func keyaboardWillHide() {
        topLabelConstraint.constant += 30
        UIView.animate(withDuration: 0.3) {
               self.view.layoutIfNeeded()
           }
    }

}
