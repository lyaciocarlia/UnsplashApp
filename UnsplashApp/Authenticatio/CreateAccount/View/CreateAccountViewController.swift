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
    @IBOutlet weak var repeatPasswordUnderlineVIew: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var botButtonConstraint: NSLayoutConstraint!
    
    init(viewModel: AuthenticationViewModel, coordinator: AuthenticationCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func confirm(_ sender: Any) {
        viewModel.createAcc(email: emailTextFeild.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @IBAction func emailFiledChanged(_ sender: Any) {
        viewModel.validateEmail(emailTextFeild.text ?? "")
    }
    
    @IBAction func passwordFieldChanged(_ sender: Any) {
        viewModel.validatePassword(passwordTextField.text ?? "")
    }
    
    @IBAction func repeatedPasswordFieldChanged(_ sender: Any) {
        viewModel.comparePasswords(target: passwordTextField.text ?? "", with: confirmPasswordTextField.text ?? "")
        errorMessageLabel.isHidden = viewModel.isPasswordEquals.value
        createAccountButton.isEnabled = viewModel.isPasswordEquals.value
        repeatPasswordUnderlineVIew.backgroundColor = !viewModel.isPasswordEquals.value ? .systemRed : .black
    }
    
    func authenticationSuccessful() {
        coordinator.finishAuthentication()
    }
    
    private func updateFieldColor () {
        let isValidCredentials = viewModel.isPasswordEquals.value
        confirmPasswordTextField.textColor = !isValidCredentials ? .systemRed : .black
    }
}

//MARK: - LIFE CYCLE
extension CreateAccountViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifcations()
        viewModel.isAuthenticated.bind { [weak self] isAuthenticated in
            if isAuthenticated {
                self?.authenticationSuccessful()
            }
        }
        viewModel.createAccError.bind { [weak self] createAccError in
            switch createAccError {
            case nil: self?.authenticationSuccessful()
            case " ": break
            default: self?.showAlert(status: createAccError!)
            }
        }
        viewModel.isPasswordEquals.bind { [weak self] _ in
            self?.updateFieldColor()
        }
    }
}

//MARK: - KEYBOARD SETUP

extension CreateAccountViewController {
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
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            botButtonConstraint.constant = keyboardHeight + 10
            UIView.animate(withDuration: 0.3) {
                   self.view.layoutIfNeeded()
               }
        }
    }
    
    @objc private func keyaboardWillHide() {
        botButtonConstraint.constant = 206
        UIView.animate(withDuration: 0.3) {
               self.view.layoutIfNeeded()
           }
    }

}

//MARK: - SHOW ALERT

extension CreateAccountViewController {
    func showAlert(status: String ) {
        var alertMessage: String
        var title: String
        switch status {
        case KeychainManager.KeychainError.duplicateEntry.localizedDescription:
            alertMessage = "An account with this email already exists."
            title = "Account already exists"
        case KeychainManager.KeychainError.unknown(OSStatus()).localizedDescription :
            alertMessage = "An unknown error occurred when creating the account."
            title = "Unknown error"
        default:
            alertMessage = ""
            title = ""
        }
    
        let alertController = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
