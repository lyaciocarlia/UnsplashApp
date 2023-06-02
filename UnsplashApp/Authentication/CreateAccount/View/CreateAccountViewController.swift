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
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet private weak var repeatPasswordUnderlineVIew: UIView!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    @IBOutlet private weak var createAccountButton: UIButton!
    @IBOutlet private weak var botButtonConstraint: NSLayoutConstraint!
    
    private var arePassEqual = false
    private var isValidEmail = false
    private var isValidPass = false
    
    init(viewModel: AuthenticationViewModel, coordinator: AuthenticationCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func confirm(_ sender: Any) {
        viewModel.createAccount(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    private func allowAccountCreation() {
        errorMessageLabel.isHidden = arePassEqual
        createAccountButton.isEnabled = arePassEqual && isValidPass && isValidEmail
        repeatPasswordUnderlineVIew.backgroundColor = arePassEqual ? .systemRed : .black
    }
    
    private func authenticationSuccessful() {
        coordinator.finishAuthentication()
    }
}

//MARK: - TEXTFIELD SETUP

extension CreateAccountViewController: UITextFieldDelegate {
    private func setupTextField(textField: UITextField) {
        textField.delegate = self
        textField.returnKeyType = .done
        textField.textColor = .label
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        confirmPasswordTextField.resignFirstResponder()
        viewModel.createAccount(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == emailTextField {
            viewModel.validateEmail(updatedText)
            allowAccountCreation()
            updateEmailFieldColor()
        }
        if textField == passwordTextField {
            viewModel.validatePassword(updatedText)
            allowAccountCreation()
            updatePassFieldColor()
        }
        if textField == confirmPasswordTextField {
            viewModel.comparePasswords(target: passwordTextField.text ?? "", with: updatedText)
            allowAccountCreation()
            updateConfirmPassFieldColor()
        }
        return true
    }
    
    private func updateConfirmPassFieldColor () {
        let isValidCredentials = arePassEqual
        confirmPasswordTextField.textColor = !isValidCredentials ? .systemRed : .black
    }
    
    private func updateEmailFieldColor () {
        let isValidCredentials = isValidPass
        emailTextField.textColor = !isValidCredentials ? .systemRed : .black
    }
    
    private func updatePassFieldColor () {
        let isValidCredentials = isValidPass
        passwordTextField.textColor = !isValidCredentials ? .systemRed : .black
    }
}

//MARK: - BIND

extension CreateAccountViewController {
    private func bind() {
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
        viewModel.isPasswordEquals.bind { [weak self] value in
            self?.arePassEqual = value
            self?.updateConfirmPassFieldColor()
        }
        viewModel.isValidEmail.bind { [weak self] value in
            self?.isValidEmail = value
            self?.updateEmailFieldColor()
        }
        viewModel.isValidPassword.bind { [weak self] value in
            self?.isValidPass = value
            self?.updatePassFieldColor()
        }
    }
}

//MARK: - LIFE CYCLE
extension CreateAccountViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifcations()
        bind()
        setupTextField(textField: emailTextField)
        setupTextField(textField: passwordTextField)
        setupTextField(textField: confirmPasswordTextField)
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
            botButtonConstraint.constant = keyboardHeight + Constants.bottomConstraintIncrease
            UIView.animate(withDuration: Constants.keyboardAnimationDuration) {
                   self.view.layoutIfNeeded()
               }
        }
    }
    
    @objc private func keyaboardWillHide() {
        botButtonConstraint.constant = Constants.bottomConstraintCreateAcc
        UIView.animate(withDuration: Constants.keyboardAnimationDuration) {
               self.view.layoutIfNeeded()
           }
    }

}

//MARK: - SHOW ALERT

extension CreateAccountViewController {
    private func showAlert(status: String ) {
        var alertMessage: String
        var title: String
        switch status {
        case KeychainManager.KeychainError.duplicateEntry.localizedDescription:
            alertMessage = AlertMessage.accountAlreadyExistsAlertMessage
            title = AlertTitle.accountAlreadyExistsAlertTitle
        case KeychainManager.KeychainError.unknown(OSStatus()).localizedDescription :
            alertMessage = AlertMessage.unknownErrorAlertMessage
            title = AlertTitle.unknownErrorAlertTitle
        default:
            alertMessage = ""
            title = ""
        }
    
        let alertController = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: ButtonsTitle.okButton, style: .default) { _ in
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
