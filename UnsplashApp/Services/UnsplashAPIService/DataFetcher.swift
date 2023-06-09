//
//  DataFetcher.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 31.05.2023.
//

import Foundation

class DataFetcher {
    func fetchImages(searchTerm: String, page: Int, completion: @escaping (SearchResult?) -> ()) {
        request(term: searchTerm, page: page) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            let decoded = self.decodeJSON(type: SearchResult.self, from: data)
            completion(decoded)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print(jsonError)
            return nil
        }
    }
    
    private func request(term: String, page: Int, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParameters(searchTerm: term, page: page)
        let url = self.url(params: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeaders()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, error)
        }
    }
    
    private func prepareHeaders() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID zH5nC-mXWDEEWfed1XQ2hpX0rhtc4HcmsK8_pzzGEZE"
        return headers
    }
    
    private func prepareParameters(searchTerm: String?, page: Int) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(page)
        parameters["per_page"] = String(API.nrOfPages)
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
}
