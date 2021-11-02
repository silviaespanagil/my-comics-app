//
//  RemoteCharacterDataSource.swift
//  MyComics
//
//  Created by Xavi on 21/10/21.
//

import Foundation
import Combine

class RemoteCharacterDataSource {
    
    static let getCharacterURL: String = "character/"
    
    private let baseURLString: String
    private let session: URLSession
    
    init(baseURL: String = Constants.baseURL, session: URLSession = URLSession.shared) {
        
        self.baseURLString = baseURL
        self.session = session
    }
    
    func getCharacter(id: Int) -> AnyPublisher<ServerBaseResponse<ServerCharacterResponse>, Error> {
        
        let apiManager = ApiManager(baseURL: baseURLString, session: session)
        
        let urlRequest = getCharacterEndpoint(id: id)
        
        return apiManager.performRequest(urlRequest: urlRequest)
    }
}

// MARK: - Endpoints

extension RemoteCharacterDataSource {
    
    func getCharacterEndpoint(id: Int) -> URLRequest {
        
        let endpoint = "\(baseURLString)\(RemoteCharacterDataSource.getCharacterURL)4005-\(id)"
        
        var components = URLComponents(string: endpoint)
        
        let queryItems = [URLQueryItem(name: "api_key", value: Constants.apiKey),
                          URLQueryItem(name: "format", value: "json"),
                          URLQueryItem(name: "field_list", value: "id,image,name,aliases,real_name,birth,deck,gender,origin,powers")]
        
        components?.queryItems = queryItems
        
        let urlRequest = URLRequest(url: (components?.url!)!)
        
        return urlRequest
    }
}
