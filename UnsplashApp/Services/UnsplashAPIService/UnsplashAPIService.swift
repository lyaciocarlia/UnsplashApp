//
//  UnsplashAPIService.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class APIService: APIServiceProtocol {
    let fetcher = DataFetcher()
    var photos = [UnsplashPhoto]()
    
    func getThePhotos() -> [UnsplashPhoto] {
        return photos
    }
    
    func request(term: String, page: Int, completion: @escaping ([UnsplashPhoto]) -> Void ){
        fetcher.fetchImages(searchTerm: term, page: page) {(searchResults) in
            guard let fetchedPhotots = searchResults else { return }
            completion(fetchedPhotots.results)
        }
    }
}
