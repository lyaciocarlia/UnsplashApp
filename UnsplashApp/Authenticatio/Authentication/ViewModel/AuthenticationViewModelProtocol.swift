//
//  AuthenticationViewModelProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

protocol AuthenticationViewModelProtocol {
    var isAuthenticated: Observable <Bool> { get }
    func authenticate(email: String, password: String)
}
