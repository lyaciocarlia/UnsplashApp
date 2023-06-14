//
//  ChangePasswordViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class ChangePasswordViewController: UIViewController, ChangePasswordViewProtocol {
    
    var viewModel: ChangePasswordViewModelProtocol
    var coordinator: BrowseCoordinatorProtocol
    
    @IBOutlet weak var buttonBottomSpacing: NSLayoutConstraint!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var repeatPasswordUnderlineView: UIView!
    
    var isValidNewPassword = false
    var isValidOldPassword = false
    var isPasswordsEqual = false
    var isButtonEnabled = false
    var isErrorMessageHiden = false
    var isPasswordChanged = false
    
    init(viewModel: ChangePasswordViewModelProtocol, coordinator: BrowseCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    @IBAction func oldPasswordFieldChanged(_ sender: Any) {
        viewModel.validateOldPassword(oldPasswordTextField.text ?? "")
    }
    
    
    @IBAction func newPasswordFieldChanged(_ sender: Any) {
        viewModel.validateNewPassword(passwordTextField.text ?? "")
    }
    
    
    @IBAction func repeatPasswordChanged(_ sender: Any) {
        viewModel.comparePasswords(target: passwordTextField.text ?? "", with: repeatPasswordTextField.text ?? "")
    }
    
    @IBAction func changePasswordButtonTapped(_ sender: Any) {
        guard let oldPassword = oldPasswordTextField.text else { return }
        guard let newPassword = passwordTextField.text else { return }
        viewModel.buttonWasTapped(newPassword: newPassword)
        showPasswordAlert()
    }
    
    
    private func showPasswordAlert() {
        let alertTitle = !isPasswordChanged ? AlertTitle.success : AlertTitle.unknownErrorAlertTitle
        let alertDesciption = !isPasswordChanged ? AlertMessage.passwordWasChanged : AlertMessage.passwordWasNotChanged
        let alertController = UIAlertController(title: alertTitle, message: alertDesciption, preferredStyle: .alert)
        let okAction = UIAlertAction(title: ButtonsTitle.okButton, style: .default) { _ in
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func changePasswordCollor() {
        let isValidPassword = viewModel.isValidNewPassword.value
        passwordTextField.textColor = isValidPassword ? .black : .systemRed
    }
    
    private func changeRepeatPasswordFieldCollor() {
        let isPasswordsEquals = viewModel.isPasswordEquals.value
        let isUnderlineRed = viewModel.isErrorMessageHiden.value
        repeatPasswordTextField.textColor = isPasswordsEquals ? .black : .systemRed
        repeatPasswordUnderlineView.backgroundColor = isUnderlineRed ? .black : .systemRed
    }
    private func  changeOldCollor() {
        let isValidOldPassword = isValidOldPassword
        oldPasswordTextField.textColor = isValidOldPassword ? .black : .systemRed
    }
    private func changeButtonStatus() {
        changePasswordButton.isEnabled = isButtonEnabled
    }
    
    private func showErrorMessage() {
        errorMessageLabel.isHidden = isErrorMessageHiden
    }
    
}

extension ChangePasswordViewController {
    private func bind() {
        viewModel.isValidOldPassord.bind { [weak self] value in
            self?.isValidOldPassword = value
            self?.changeOldCollor()
        }
        viewModel.isValidNewPassword.bind { [weak self] value in
            self?.isValidNewPassword = value
            self?.changePasswordCollor()
        }
        viewModel.isPasswordEquals.bind { [weak self] value in
            self?.isPasswordsEqual = value
            self?.changeRepeatPasswordFieldCollor()
        }
        viewModel.isButtonEnabled.bind { [weak self] value in
            self?.isButtonEnabled = value
            self?.changeButtonStatus()
        }
        viewModel.isErrorMessageHiden.bind { [weak self] value in
            self?.isErrorMessageHiden = value
            self?.showErrorMessage()
        }
        viewModel.isPasswordChanged.bind { [weak self] value in
            self?.isPasswordChanged = value
        }
    }
}
