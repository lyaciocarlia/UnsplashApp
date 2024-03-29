//
//  LoginViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {
    
    var viewModel: AuthenticationViewModel
    var coordinator: AuthenticationCoordinatorProtocol
    
    private var isValidEmail = false
    private var isValidPass = false
    
    @IBOutlet private weak var fadedImage: UIImageView!
    @IBOutlet private weak var emailTextField: CustomTextField!
    @IBOutlet private weak var errorMessage: UILabel!
    @IBOutlet private weak var passwordTextField: CustomTextField!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var loginButton: UIButton!
    
    init(viewModel: AuthenticationViewModel, coordinator: AuthenticationCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func buttonWasTapped(_ sender: Any) {
        authenticate()
    }
    
    @IBAction func openCreateAccScreen(_ sender: Any) {
        coordinator.openCreateAccScreen()
    }
    
    @IBAction func openForgotPassScreen(_ sender: Any) {
        coordinator.openForgotPasswordScreen()
    }
    
    private func authenticationSuccessful() {
        coordinator.finishAuthentication()
    }
    
    private func showErrorCredentialsAlert() {
        let alertController = UIAlertController(title: AlertTitle.couldNotLoginAlertTitle,
                                                message: AlertMessage.couldNotLoginAlertMessage,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: ButtonsTitle.okButton, style: .default) { _ in }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - LIFE CYCLE

extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        registerKeyboardNotifcations()
        setupTextField(textField: emailTextField)
        setupTextField(textField: passwordTextField)
    }
}

// MARK: - UITEXT FIELD SETUP

extension LoginViewController: UITextFieldDelegate {
    
    private func authenticate() {
        passwordTextField.resignFirstResponder()
        viewModel.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "" )
    }
    
    private func setupTextField(textField: UITextField) {
        textField.delegate = self
        textField.returnKeyType = .done
        textField.textColor = .label
        textField.autocorrectionType = .no
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        authenticate()
        return true
    }
    
    private func updateButtonStatus() {
        loginButton.isEnabled = isValidPass && isValidEmail
    }
    
    private func updatePasswordFieldColor () {
        let isValidPassword = isValidPass
        passwordTextField.textColor = !isValidPassword ? .systemRed : .black
    }
    
    private func updateEmailFieldColor () {
        let isValidCredentials = isValidEmail
        emailTextField.textColor = !isValidCredentials ? .systemRed : .black
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == emailTextField {
            viewModel.validateEmail(updatedText)
            updateButtonStatus()
            updateEmailFieldColor()
        }
        
        if textField == passwordTextField {
            viewModel.validatePassword(updatedText)
            errorMessage.isHidden = viewModel.isErrorMessageHiden.value
            updateButtonStatus()
            updatePasswordFieldColor()
        }
        return true
    }
}

//MARK: - SETUP BINDINGS

extension LoginViewController {
    private func setupBindings() {
        viewModel.isAuthenticated.bind { [weak self] isAuthenticated in
            if isAuthenticated {
                self?.authenticationSuccessful()
            }
        }
        viewModel.wrongPassOrEmail.bind { [weak self] wrongPassOrEmail in
            if wrongPassOrEmail {
                self?.showErrorCredentialsAlert()
            }
        }
        viewModel.isValidPassword.bind { [weak self] value in
            self?.isValidPass = value
            self?.updatePasswordFieldColor()
        }
        viewModel.isValidEmail.bind {  [weak self] value in
            self?.isValidEmail = value
            self?.updateEmailFieldColor()
        }
    }
}


// MARK: - UI SETUP

extension LoginViewController {
    
    private func setupUI() {
        navigationController?.navigationBar.isTranslucent = true
        let image = UIImage(named: Images.backgroundImageName )
        fadedImage.image = applyGradientToImage(image: image ?? UIImage())
        setupTextField(textField: emailTextField)
    }
    
   private func applyGradientToImage(image: UIImage) -> UIImage? {
        
        let imageSize = fadedImage.frame.size
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        image.draw(at: .zero)
        
        let colors = GradientColors.whiteToClear
        
        let locations: [CGFloat] = [0, 1]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: locations) else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        let startPoint = CGPoint(x: imageSize.width / Constants.devideByTwo, y: Constants.gradientY)
        let endPoint = CGPoint(x: imageSize.width / Constants.devideByTwo, y: imageSize.height)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return gradientImage
    }
}

//MARK: - KEYBOARD SETUP

extension LoginViewController {
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
            bottomConstraint.constant = keyboardHeight + Constants.bottomConstraintIncrease
            UIView.animate(withDuration: Constants.keyboardAnimationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyaboardWillHide() {
        bottomConstraint.constant = Constants.bottomConstraint
        UIView.animate(withDuration: Constants.keyboardAnimationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}
