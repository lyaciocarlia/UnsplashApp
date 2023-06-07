//
//  AppService.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class AppService: AppServiceProtocol {
    let authenticationService: AuthenticationServiceProtocol = AuthentitacionService()
    let apiService:APIServiceProtocol = APIService()
    
    func login(email: String, password: String) -> Bool {
        return authenticationService.login(email: email, password: password )
    }
    
    func createAcc(user: User) -> Error? {
        let status = authenticationService.createAccount(user: user)
        return status
    }
    
    func getThePhotos() async -> [UnsplashPhoto] {
        return apiService.getThePhotos()
    }
    
    func request(term: String, page: Int, complention: @escaping ([UnsplashPhoto]) -> Void) {
        apiService.request(term: term, page: page) { fetchedPhotos in
            complention(fetchedPhotos)
        }
    }
    func checkForAccount() -> Bool {
        return authenticationService.checkForAccount()
    }
}
