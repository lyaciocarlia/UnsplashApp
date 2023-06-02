//
//  ForgotPasswordViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController, ForgotPasswordViewProtocol, UITextFieldDelegate {
    
    var isValidEmail = false
    
    var viewModel: AuthenticationViewModelProtocol
    var coordinator: AuthenticationCoordinatorProtocol
    @IBOutlet weak var botButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var emailUnderlineView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    
    init(viewModel: AuthenticationViewModelProtocol, coordinator: AuthenticationCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinds()
        registerKeyboardNotifcations()
        emailTextField.delegate = self
    }
    
    @IBAction func confirm(_ sender: Any) {
        showPass()
    }
    
    func showPass() {
        guard let email = emailTextField.text else { return }
        var title = Constants.showPassErrorAlertTitle
        var message = Constants.showPassErrorAlertMessage
        if let passwordData = KeychainManager.getPassword(for: email) {
            let password = String(decoding: passwordData, as: UTF8.self)
            title = Constants.showPassAlertTitle
            message = "\(Constants.showPassAlertMessage) \(password)"
        }
        
        let alertWithPasword = UIAlertController(title: title,
                                                 message: message,
                                                 preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: Constants.okButton, style: .default) { _ in
            self.coordinator.goBackToLoginScreen()
        }
        alertWithPasword.addAction(okAction)
        self.present(alertWithPasword, animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == emailTextField {
            viewModel.validateEmail(updatedText)
            errorMessageLabel.isHidden = isValidEmail
            confirmButton.isEnabled = isValidEmail
            emailUnderlineView.backgroundColor = isValidEmail ? .systemRed : .black
            updateFieldColor()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        showPass()
        return true
    }
    
    private func updateFieldColor () {
        let isValidCredentials = isValidEmail
        emailTextField.textColor = !isValidCredentials ? .systemRed : .black
    }
}

//MARK: - KEYBOARD SETUP

extension ForgotPasswordViewController {
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
        botButtonConstraint.constant = Constants.bottomConstraint
        UIView.animate(withDuration: Constants.keyboardAnimationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}

//MARK: - SET UP BINDS

extension ForgotPasswordViewController {
    private func setUpBinds() {
        viewModel.isValidEmail.bind { [weak self] value in
            self?.isValidEmail = value
            self?.updateFieldColor()
        }
    }
}
