//
//  AppServiceProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

protocol AppServiceProtocol {
    func login(email: String, password: String) -> Bool
    func createAcc(user: User) -> Error?
}
