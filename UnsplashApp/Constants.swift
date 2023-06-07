//
//  Constants.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 02.06.2023.
//

import Foundation
import UIKit

struct Constants {
    static let minimPasswordSize = 5
    static let devideByTwo = 2.0
    static let gradientY = 0.0
    static let keyboardAnimationDuration = 0.3
    static let bottomConstraintIncrease = 10.0
    static let bottomConstraint = 231.0
    static let bottomConstraintCreateAcc = 206.0
    static let emailRegex = "gmail.com"
    static let gradientColors = [UIColor(red: 255, green: 255, blue: 255, alpha: 0.5).cgColor, UIColor.white.cgColor]
    static let serviceName = "Unsplash.com"
}

struct Images {
    static let backgroundImageName = "hossein-nasr-oVWhUno9nSw-unsplash 2"
}

struct ButtonsTitle {
    static let okButton = "OK"
}

struct AlertMessage {
    static let couldNotLoginAlertMessage = "Wrong email or password."
    static let showPassAlertMessage = "That's your passwod - "
    static let accountAlreadyExistsAlertMessage = "An account with this email already exists."
    static let unknownErrorAlertMessage = "An unknown error occurred when creating the account."
    static let showPassErrorAlertMessage = "We could not find wour password :("
}

struct AlertTitle {
    static let couldNotLoginAlertTitle = "Could not login"
    static let accountAlreadyExistsAlertTitle = "Account already exists"
    static let showPassAlertTitle = "REMEMBER !"
    static let showPassErrorAlertTitle = "ERROR"
    static let unknownErrorAlertTitle = "Unknown error"
}

struct Screens {
    static let firstScreen = 0
    static let secondScreen = 1
    static let thirdScreen = 2
}
