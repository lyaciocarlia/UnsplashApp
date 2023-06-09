//
//  PictureDetailsViewModel.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class PictureDetailsViewModel: PictureDetailsViewModelProtocol {
    
    let service = AppService()
    var isAdded: Observable<Bool> = Observable(false)
    var photos: Observable<[CoreDataPhoto]> = Observable([CoreDataPhoto]())
    
    func getPhoto(at index: Int) -> CoreDataPhoto? {
        service.getPhoto(at: index)
    }
    
    func numberOfPhotos() -> Int {
        service.numberOfPhotos()
    }
    
    func getThePhotos() {
        self.photos.value = service.convertPhotoToCoreDataPhoto() ?? []
    }
    
    func deletePhoto(with id: String) {
        service.deletePhoto(with: id)
        isAdded.value = false
    }
    
    func setState(state: Bool) {
        isAdded.value = state
    }
    
    func isLikedOrNot(with id: String) -> Bool {
        service.isLikedOrNot(with: id)
    }
    
    func addPhoto(photo: CoreDataPhoto) {
        service.addPhoto(photo: photo)
        isAdded.value = true
    }
    
}
