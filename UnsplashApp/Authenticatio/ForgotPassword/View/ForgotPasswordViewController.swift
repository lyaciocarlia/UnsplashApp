//
//  ForgotPasswordViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController, ForgotPasswordViewProtocol {
    
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

    }
    
    @IBAction func confirm(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let passwordData = KeychainManager.getPassword(for: email) else { return }
        let password = String(decoding: passwordData, as: UTF8.self)

        let alertWithPasword = UIAlertController(title: "REMEMBER!",
                                                 message: "That's your passwod - \(password)",
                                                 preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.coordinator.goBackToLoginScreen()
        }
        alertWithPasword.addAction(okAction)
        self.present(alertWithPasword, animated: true, completion: nil)
    }
    
    @IBAction func emailFieldChanged(_ sender: Any) {
       viewModel.validateEmail(emailTextField.text ?? "")
        errorMessageLabel.isHidden = viewModel.isValidEmail.value
        confirmButton.isEnabled = viewModel.isValidEmail.value
        emailUnderlineView.backgroundColor = !viewModel.isValidEmail.value ? .systemRed : .black
    }
    
    private func updateFieldColor () {
        let isValidCredentials = viewModel.isValidEmail.value
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
            botButtonConstraint.constant = keyboardHeight + 10
            UIView.animate(withDuration: 0.3) {
                   self.view.layoutIfNeeded()
               }
        }
    }
    
    @objc private func keyaboardWillHide() {
        botButtonConstraint.constant = 231
        UIView.animate(withDuration: 0.3) {
               self.view.layoutIfNeeded()
           }
    }
}

//MARK: - SET UP BINDS

extension ForgotPasswordViewController {
    private func setUpBinds() {
        viewModel.isValidEmail.bind { [weak self] _ in
            self?.updateFieldColor()
        }
    }
}
