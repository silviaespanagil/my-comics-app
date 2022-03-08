//
//  RemoteSearchDataSource.swift
//  MyComics
//
//  Created by Xavi on 18/10/21.
//

import Foundation
import Combine
import Resolver

class RemoteSearchDataSource {
    
    static let searchURL: String = "search/"
    
    private let apiManager: ApiManager
    private let baseURL: URL
    
    init(apiManager: ApiManager? = nil, baseURL: URL? = nil) {
        self.apiManager = apiManager ?? Resolver.resolve()
        self.baseURL = baseURL ?? Resolver.resolve()
      }
    
    func searchCharacter(searchTerm: String) -> AnyPublisher<ServerBaseArrayResponse<ServerCharacterResponse>, Error> {
        
        let urlRequest = getSearchCharacterEndpoint(searchTerm: searchTerm)
        
        return apiManager.performRequest(urlRequest: urlRequest)
    }
}

// MARK: - Endpoints

extension RemoteSearchDataSource {
    
    func getSearchCharacterEndpoint(searchTerm: String) -> URLRequest {
        
        let endpoint = "\(baseURL)\(RemoteSearchDataSource.searchURL)"
        
        var components = URLComponents(string: endpoint)
        
        let queryItems = [URLQueryItem(name: "api_key", value: Constants.apiKey),
                          URLQueryItem(name: "query", value: searchTerm),
                          URLQueryItem(name: "format", value: "json"),
                          URLQueryItem(name: "field_list", value: "id,image,name,aliases,real_name,gender"),
                          URLQueryItem(name: "resources", value: "character"),
                          URLQueryItem(name: "limit", value: "100" )]
        
        components?.queryItems = queryItems
        
        let urlRequest = URLRequest(url: (components?.url!)!)
        
        return urlRequest
    }
}
