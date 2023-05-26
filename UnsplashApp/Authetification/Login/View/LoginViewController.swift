//
//  LoginViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit
import CoreImage

class LoginViewController: UIViewController, LoginViewProtocol {

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
        viewModel?.isAuthenticated.bind { [weak self] isAuthenticated in
            if isAuthenticated {
                self?.authenticationSuccessful()
            }
        }
    }
    
    @IBAction func createAcc(_ sender: Any) {
        coordinator?.openCreateAccScreen()
    }
    
    @IBAction func forgotPass(_ sender: Any) {
        coordinator?.openForgotPasswordScreen()
    }
    
    func authenticationSuccessful() {
        coordinator?.finishAuthentication()
    }
    
    func applyGradientToImage(image: UIImage) -> UIImage? {
        
        let imageSize = fadedImage.frame.size
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        // Draw the original image
        image.draw(at: .zero)
        
        // Define gradient colors
        let colors = [UIColor(red: 255, green: 255, blue: 255, alpha: 0.5).cgColor, UIColor.white.cgColor]
        
        // Create gradient parameters
        let locations: [CGFloat] = [0, 1]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: locations) else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        // Apply the gradient to the image
        let startPoint = CGPoint(x: imageSize.width / 2, y: 0.0)
        let endPoint = CGPoint(x: imageSize.width / 2, y: imageSize.height)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        
        // Get the resulting image from the context
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return gradientImage
    }


    
}
