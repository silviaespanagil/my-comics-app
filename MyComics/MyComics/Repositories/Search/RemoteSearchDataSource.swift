//
//  RemoteSearchDataSource.swift
//  MyComics
//
//  Created by Xavi on 18/10/21.
//

import Foundation
import Combine

class RemoteSearchDataSource {
    
    static let searchURL: String = "search/"
    
    private let baseURLString: String
    private let session: URLSession
    
    init(baseURL: String = Constants.baseURL, session: URLSession = URLSession.shared) {
        
        self.baseURLString = baseURL
        self.session = session
    }
    
    func searchCharacter(searchTerm: String) -> AnyPublisher<ServerBaseArrayResponse<ServerCharacterResponse>, Error> {
        
        let apiManager = ApiManager(baseURL: baseURLString, session: session)
        
        let urlRequest = getSearchCharacterEndpoint(searchTerm: searchTerm)
        
        return apiManager.performRequest(urlRequest: urlRequest)
    }
}

// MARK: - Endpoints

extension RemoteSearchDataSource {
    
    func getSearchCharacterEndpoint(searchTerm: String) -> URLRequest {
        
        let endpoint = "\(baseURLString)\(RemoteSearchDataSource.searchURL)"
        
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
