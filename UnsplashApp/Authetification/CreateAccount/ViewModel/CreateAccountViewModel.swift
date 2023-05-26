//
//  CreateAccountViewModel.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class CreateAccountViewModel: CreateAccountViewModelProtocol {
    var isAuthenticated: Observable<Bool> = Observable(false)

    func authenticate(username: String, password: String) {
        self.isAuthenticated.value = true
    }
}
