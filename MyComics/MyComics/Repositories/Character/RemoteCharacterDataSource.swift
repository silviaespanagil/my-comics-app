//
//  RemoteCharacterDataSource.swift
//  MyComics
//
//  Created by Xavi on 21/10/21.
//

import Foundation
import Combine
import Resolver

class RemoteCharacterDataSource {
    
    var apiManager: ApiManager
    private let baseURL: URL
    static let getCharacterURL: String = "character/"
    
    init(apiManager: ApiManager? = nil, baseURL: URL? = nil) {
        self.apiManager = apiManager ?? Resolver.resolve()
        self.baseURL = baseURL ?? Resolver.resolve()
      }
   
    func getCharacter(id: Int) -> AnyPublisher<ServerBaseResponse<ServerCharacterResponse>, Error> {
        
        let urlRequest = getCharacterEndpoint(id: id)
        
        return apiManager.performRequest(urlRequest: urlRequest)
    }
}

// MARK: - Endpoints

extension RemoteCharacterDataSource {
    
    func getCharacterEndpoint(id: Int) -> URLRequest {
        
        let endpoint = "\(baseURL)\(RemoteCharacterDataSource.getCharacterURL)4005-\(id)"
        
        var components = URLComponents(string: endpoint)
        
        let queryItems = [URLQueryItem(name: "api_key", value: Constants.apiKey),
                          URLQueryItem(name: "format", value: "json"),
                          URLQueryItem(name: "field_list", value: "id,image,name,aliases,real_name,birth,deck,gender,origin,powers")]
        
        components?.queryItems = queryItems
        
        let urlRequest = URLRequest(url: (components?.url!)!)
        
        return urlRequest
    }
}
