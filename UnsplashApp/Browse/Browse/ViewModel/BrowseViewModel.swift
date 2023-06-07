//
//  BrowseViewModel.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class BrowseViewModel: BrowseViewModelProtocol {
    
    var service: AppServiceProtocol = AppService()
    var photos: Observable<[UnsplashPhoto]> = Observable([UnsplashPhoto]())
    private var currentPage = 1
    private var isLoading = false
    private var term = String()
    
    func request(term: String) {
        currentPage = 1
        service.request(term: term, page: currentPage) { fetchedPhototois in
            self.term = term
            DispatchQueue.main.async {
                self.photos.value = fetchedPhototois
            }
        }
    }
    
    func getThePhotosForStartApp() {
        self.request(term: "Moldova")
        
    }
    
    func nrOfPhotos() -> Int {
        return photos.value.count
    }
    
    func loadMorePhotos() {
        guard !isLoading else { return }
        isLoading = true
        service.request(term: term, page: currentPage) { [weak self] fetchedPhotos in
            DispatchQueue.main.async {
                if self?.currentPage == 1 {
                    self?.photos.value = fetchedPhotos
                } else {
                    self?.photos.value.append(contentsOf: fetchedPhotos)
                }
                self?.currentPage += 1
                self?.isLoading = false
            }
        }
    }
}
