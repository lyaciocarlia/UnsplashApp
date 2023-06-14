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
    
    let coreDataStack = CoreDataStack()
    lazy var storageService = StorageService(managedObjectContext: coreDataStack.mainContext,
                                     coreDataStack: coreDataStack)
    
    func deleteAllPhotos() {
        storageService.deleteAllPhotos()
    }
    
    func deletePhoto(with id: String) {
        storageService.deletePhoto(with: id)
    }
    
    func convertPhotoToCoreDataPhoto() -> [CoreDataPhoto]? {
        storageService.convertPhotoToCoreDataPhoto()
    }
    
    func addPhoto(photo: CoreDataPhoto) {
        storageService.addPhoto(photo: photo)
    }
    
    func isLikedOrNot(with id: String) -> Bool {
        storageService.isLikedOrNot(with: id)
    }
    
    func getPhoto(at index: Int) -> CoreDataPhoto? {
        return storageService.getPhoto(at: index)
    }
    
    func numberOfPhotos() -> Int {
        return storageService.numberOfPhotos()
    }
    
    func login(email: String, password: String) -> Bool {
        return authenticationService.login(email: email, password: password )
    }
    
    func createAcc(user: User) -> Error? {
        let status = authenticationService.createAccount(user: user)
        return status
    }
    
    func request(term: String, page: Int, complention: @escaping ([UnsplashPhoto]) -> Void) {
        apiService.request(term: term, page: page) { fetchedPhotos in
            complention(fetchedPhotos)
        }
    }
    
    func checkForAccount() -> Bool {
        return authenticationService.checkForAccount()
    }
    
    func updateAccountPassword(newPassword: String) -> Bool {
        return authenticationService.updateAccountPassword(newPassword: newPassword)
    }
    
    func logOut() -> Error? {
        return authenticationService.louOut()
    }
}
