//
//  UnsplashStorageService.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import CoreData

class StorageService: StorageServiceProtocol {
    let context: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    var photos: [Photo] = []
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
      self.context = managedObjectContext
      self.coreDataStack = coreDataStack
    }
    
    private func refreshPhotos() {
        guard let photos = getPhotosFromDB() else { return }
        self.photos = photos
    }
    
    private func getPhotosFromDB() -> [Photo]? {
        do {
            let photos = try context.fetch(Photo.fetchRequest())
            return photos.isEmpty ? nil :  photos
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func isLikedOrNot(with id: String) -> Bool {
        photos = getPhotosFromDB() ?? []
        return photos.contains { photo in
            photo.id == id
        }
    }
    
    func convertPhotoToCoreDataPhoto() -> [CoreDataPhoto]? {
        guard let corePhoto = getPhotosFromDB() else { return nil }
        let photos = corePhoto.map { photo in
            let id = photo.id  ?? " "
            let location = photo.location
            let license = photo.license
            let date = photo.date  ?? " "
            let imageURL = photo.imageURL  ?? " "
            
            return CoreDataPhoto(imageURL: imageURL, id: id, location: location, date: date, license: license)
        }
        return photos
    }
    
    func numberOfPhotos() -> Int {
        return getPhotosFromDB()?.count ?? Constants.zeroTasks
    }
    
    func getPhoto(at index: Int) -> CoreDataPhoto? {
        let photos = convertPhotoToCoreDataPhoto()
        return photos?[index]
    }
    
//    func parseTaskList(section: Int) -> [Task] {
//        if section == Constants.firstSection && nrOfActiveTasks() != 0 {
//            return activeTasks
//        } else {
//            return completedTasks
//        }
//    }
    
    private func saveContext() {
        coreDataStack.saveContext(context)
    }
    
//    private func getDBTaskIndex(task: Task) -> Int? {
//        refreshTasks()
//        guard let index = (tasks.firstIndex { $0.actionDate == task.actionDate }) else { return nil }
//        return index
//    }
    
    func addPhoto(photo: CoreDataPhoto) {
        let photoToAdd = Photo(context: context)
        photoToAdd.id = photo.id
        photoToAdd.date = photo.date
        photoToAdd.license = photo.license
        photoToAdd.location = photo.location
        photoToAdd.imageURL = photo.imageURL
        photoToAdd.isAdded = true
        saveContext()
        refreshPhotos()
    }
    
    func deletePhoto(with id: String) {
        photos = getPhotosFromDB() ?? []
        photos.forEach { photo in
            if photo.id == id {
                context.delete(photo)
                saveContext()
            }
        }
    }
    
    func deleteAllPhotos() {
        photos = getPhotosFromDB() ?? []
        photos.forEach { photo in
            context.delete(photo)
            saveContext()
        }
    }
}
