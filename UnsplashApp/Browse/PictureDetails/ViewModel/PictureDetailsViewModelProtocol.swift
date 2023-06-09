//
//  PictureDetailsViewModelProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

protocol PictureDetailsViewModelProtocol {
    func deletePhoto(with id: String)
    func addPhoto(photo: CoreDataPhoto)
    func isLikedOrNot(with id: String) -> Bool
    func setState(state: Bool)
    func getPhoto(at index: Int) -> CoreDataPhoto?
    func numberOfPhotos() -> Int
    func getThePhotos()
    
    var isAdded: Observable<Bool> { get set }
    var photos: Observable<[CoreDataPhoto]> { get set }
}
