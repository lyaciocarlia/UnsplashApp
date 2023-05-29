//
//  CreateAccountViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class CreateAccountViewController: UIViewController, CreateAccountViewProtocol {    

    var viewModel: AuthenticationViewModel
    var coordinator: AuthenticationCoordinatorProtocol
    
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var topLabelConstraint: NSLayoutConstraint!
    
    init(viewModel: AuthenticationViewModel, coordinator: AuthenticationCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifcations()
        viewModel.isAuthenticated.bind { [weak self] isAuthenticated in
            if isAuthenticated {
                self?.authenticationSuccessful()
            }
        }
        viewModel.createAccError.bind { [weak self] createAccError in
//            if createAccError {
//                self?.authenticationSuccessful()
//            }
        }
    }
    
    //func alert(
    
    @IBAction func confirm(_ sender: Any) {
        viewModel.createAcc(email: emailTextFeild.text ?? "", password: passwordTextField.text ?? "")
    }
    
    func authenticationSuccessful() {
        coordinator.finishAuthentication()
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
        topLabelConstraint.constant = 265
        UIView.animate(withDuration: 0.3) {
               self.view.layoutIfNeeded()
           }
    }

    @objc private func keyaboardWillHide() {
        topLabelConstraint.constant = 315
        UIView.animate(withDuration: 0.3) {
               self.view.layoutIfNeeded()
           }
    }

}
