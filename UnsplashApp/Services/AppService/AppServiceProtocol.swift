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
    func checkForAccount() -> Bool
    func request(term: String, page: Int, complention: @escaping ([UnsplashPhoto]) -> Void)
}
