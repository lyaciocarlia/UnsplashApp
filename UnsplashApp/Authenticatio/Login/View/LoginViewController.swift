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
    
    @IBOutlet weak var fadedImage: UIImageView!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginButton: UIButton!
    
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
    
    @IBAction func emailWasChanged(_ sender: Any) {
        viewModel.validateEmail(emailTextField.text!)
        updateButtonStatus()
    }
    
    @IBAction func passwordWasChanged(_ sender: Any) {
        viewModel.validatePassword(passwordTextField.text!)
        errorMessage.isHidden = viewModel.isErrorMessageHiden.value
        updateButtonStatus()
    }
    
    func authenticationSuccessful() {
        coordinator.finishAuthentication()
    }
    
    func showErrorCredentialsAlert() {
        let alertController = UIAlertController(title: "Could not login", message: "Wrong email or password.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func updateButtonStatus() {
        loginButton.isEnabled = viewModel.isValidEmail.value && viewModel.isValidPassword.value
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
    }
}


// MARK: - LIFE CYCLE

extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        registerKeyboardNotifcations()
    }
}

// MARK: - UI SETUP

extension LoginViewController {
    
    func setupUI() {
        navigationController?.navigationBar.isTranslucent = true
        let image = UIImage(named: "hossein-nasr-oVWhUno9nSw-unsplash 2")
        fadedImage.image = applyGradientToImage(image: image ?? UIImage())
        setupTextField(textField: emailTextField)
    }
    
    func applyGradientToImage(image: UIImage) -> UIImage? {
        
        let imageSize = fadedImage.frame.size
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        image.draw(at: .zero)
        
        let colors = [UIColor(red: 255, green: 255, blue: 255, alpha: 0.5).cgColor, UIColor.white.cgColor]
        
        let locations: [CGFloat] = [0, 1]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: locations) else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        let startPoint = CGPoint(x: imageSize.width / 2, y: 0.0)
        let endPoint = CGPoint(x: imageSize.width / 2, y: imageSize.height)
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
            bottomConstraint.constant = keyboardHeight + 10
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyaboardWillHide() {
        bottomConstraint.constant = 231
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}

// MARK: - UITEXT FIELD SETUP

extension LoginViewController: UITextFieldDelegate {
    
    private func authenticate() {
        passwordTextField.resignFirstResponder()
        viewModel.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "" )
    }
    
    func setupTextField(textField: UITextField) {
        textField.returnKeyType = .done
        textField.textColor = .label
        textField.autocorrectionType = .no
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

