//
//  LoginViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit
import CoreImage

class LoginViewController: UIViewController, LoginViewProtocol {
<<<<<<< HEAD
    
    var viewModel: AuthenticationViewModel?
    var coordinator: AuthetificationCoordinatorProtocol?
    
    @IBOutlet weak var fadedImage: UIImageView!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    @IBAction func login(_ sender: Any) {
        authenticate()
    }
    
    @IBAction func openCreateAccScreen(_ sender: Any) {
        coordinator?.openCreateAccScreen()
    }
    
    @IBAction func openForgotPassScreen(_ sender: Any) {
        coordinator?.openForgotPasswordScreen()
    }
    
    func authenticationSuccessful() {
        coordinator?.finishAuthentication()
    }
    
}

// MARK: - LIFE CYCLE

extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
=======

    var viewModel: LoginViewModelProtocol?
    var coordinator: AuthetificationCoordinatorProtocol?
    
    @IBOutlet weak var fadedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

            // Set the navigation bar to be transparent
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
       
        let image = UIImage(named: "hossein-nasr-oVWhUno9nSw-unsplash 2")
        fadedImage.image = applyGradientToImage(image: image ?? UIImage())

    }
    
    @IBAction func login(_ sender: Any) {
        viewModel?.authenticate(username: "", password: "")
>>>>>>> d574f18 (Create the UI for the login screen~)
        viewModel?.isAuthenticated.bind { [weak self] isAuthenticated in
            if isAuthenticated {
                self?.authenticationSuccessful()
            }
        }
    }
<<<<<<< HEAD
}

// MARK: - UI SETUP

extension LoginViewController {
    
    func setupUI() {
        navigationController?.navigationBar.isTranslucent = true
        let image = UIImage(named: "hossein-nasr-oVWhUno9nSw-unsplash 2")
        fadedImage.image = applyGradientToImage(image: image ?? UIImage())
        setupTextField(textField: emailTextField)
=======
    
    @IBAction func createAcc(_ sender: Any) {
        coordinator?.openCreateAccScreen()
    }
    
    @IBAction func forgotPass(_ sender: Any) {
        coordinator?.openForgotPasswordScreen()
    }
    
    func authenticationSuccessful() {
        coordinator?.finishAuthentication()
>>>>>>> d574f18 (Create the UI for the login screen~)
    }
    
    func applyGradientToImage(image: UIImage) -> UIImage? {
        
        let imageSize = fadedImage.frame.size
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
<<<<<<< HEAD
        image.draw(at: .zero)
        
        let colors = [UIColor(red: 255, green: 255, blue: 255, alpha: 0.5).cgColor, UIColor.white.cgColor]
        
=======
        // Draw the original image
        image.draw(at: .zero)
        
        // Define gradient colors
        let colors = [UIColor(red: 255, green: 255, blue: 255, alpha: 0.5).cgColor, UIColor.white.cgColor]
        
        // Create gradient parameters
>>>>>>> d574f18 (Create the UI for the login screen~)
        let locations: [CGFloat] = [0, 1]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: locations) else {
            UIGraphicsEndImageContext()
            return nil
        }
        
<<<<<<< HEAD
=======
        // Apply the gradient to the image
>>>>>>> d574f18 (Create the UI for the login screen~)
        let startPoint = CGPoint(x: imageSize.width / 2, y: 0.0)
        let endPoint = CGPoint(x: imageSize.width / 2, y: imageSize.height)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        
<<<<<<< HEAD
=======
        // Get the resulting image from the context
>>>>>>> d574f18 (Create the UI for the login screen~)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return gradientImage
    }
<<<<<<< HEAD
}

// MARK: - UITEXT FIELD SETUP

extension LoginViewController: UITextFieldDelegate {
    
    private func authenticate() {
        passwordTextField.resignFirstResponder()
        viewModel?.authenticate(email: emailTextField.text ?? "", password: passwordTextField.text ?? "" )
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
=======


    
>>>>>>> d574f18 (Create the UI for the login screen~)
}
