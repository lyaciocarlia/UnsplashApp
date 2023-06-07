//
//  UnsplashAPIServiceProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

protocol APIServiceProtocol {
    func request(term: String, page: Int, completion: @escaping ([UnsplashPhoto]) -> Void )
    func getThePhotos() -> [UnsplashPhoto]
}
