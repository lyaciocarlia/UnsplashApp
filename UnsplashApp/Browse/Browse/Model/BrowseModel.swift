//
//  BrowseModel.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

struct SearchResult: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let createdAt: String
    let id: String
    let width: Int
    let height: Int
    let urls: [URLKind.RawValue: String]
    let user: UserData
    let license: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case urls
        case user
        case license = "sponsorship"
        case createdAt = "created_at"
    }
}

struct UserData: Decodable {
    let id: String
    let username: String
    let name: String
    let location: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case location
    }
}

enum URLKind: String {
    case raw
    case full
    case regular
    case small
    case thumb
}


