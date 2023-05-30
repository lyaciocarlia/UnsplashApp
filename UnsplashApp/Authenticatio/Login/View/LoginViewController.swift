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
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    init(viewModel: AuthenticationViewModel, coordinator: AuthenticationCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func login(_ sender: Any) {
        authenticate()
    }
    
    @IBAction func openCreateAccScreen(_ sender: Any) {
        coordinator.openCreateAccScreen()
    }
    
    @IBAction func openForgotPassScreen(_ sender: Any) {
        coordinator.openForgotPasswordScreen()
    }
    
    func authenticationSuccessful() {
        coordinator.finishAuthentication()
    }
    
    func wrongPassOrEmail() {
        let alertController = UIAlertController(title: "Could not login", message: "Wrong email or password.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)  
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
                self?.wrongPassOrEmail()
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

