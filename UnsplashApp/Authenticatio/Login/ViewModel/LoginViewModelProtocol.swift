//
//  LoginViewModelProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    var isAuthenticated: Observable <Bool> { get }
    func authenticate(username: String, password: String)
}
