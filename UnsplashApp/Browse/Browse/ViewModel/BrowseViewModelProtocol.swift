//
//  BrowseViewModelProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

protocol BrowseViewModelProtocol {
    var photos: Observable<[UnsplashPhoto]> { get set }
    func request(term: String)
    func nrOfPhotos() -> Int
    func getThePhotosForStartApp()
    func loadMorePhotos()
}
