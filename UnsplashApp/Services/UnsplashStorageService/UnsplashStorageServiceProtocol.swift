//
//  UnsplashStorageServiceProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

protocol StorageServiceProtocol {
    func deletePhoto(with id: String)
    func addPhoto(photo: CoreDataPhoto)
    func getPhoto(at index: Int) -> CoreDataPhoto?
    func numberOfPhotos() -> Int
    func isLikedOrNot(with id: String) -> Bool
    func convertPhotoToCoreDataPhoto() -> [CoreDataPhoto]?
    func deleteAllPhotos()
}
