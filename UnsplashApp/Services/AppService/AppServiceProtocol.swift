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
    func deletePhoto(with id: String)
    func addPhoto(photo: CoreDataPhoto)
    func getPhoto(at index: Int) -> CoreDataPhoto?
    func numberOfPhotos() -> Int
    func isLikedOrNot(with id: String) -> Bool
    func convertPhotoToCoreDataPhoto() -> [CoreDataPhoto]?
    func deleteAllPhotos()
}
