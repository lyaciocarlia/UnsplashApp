//
//  Photo+CoreDataProperties.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 08.06.2023.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var imageURL: String?
    @NSManaged public var id: String?
    @NSManaged public var location: String?
    @NSManaged public var date: String?
    @NSManaged public var license: String?
    @NSManaged public var isAdded: Bool
}

extension Photo : Identifiable {

}
