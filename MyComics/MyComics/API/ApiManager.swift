//
//  ApiManager.swift
//  MyComics
//
//  Created by Xavi on 18/10/21.
//

import Foundation
import Combine

class ApiManager {
    
    var baseURL: URL
    var session: URLSession
    
    init(baseURL: String, session: URLSession = URLSession.shared) {
        
        self.baseURL = URL(string: baseURL)!
        self.session = session
    }
    
    func performRequest<T: Decodable>(urlRequest: URLRequest) -> AnyPublisher<T, Error> {
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { $0 as Error }
            .tryMap { data, response -> Data in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HTTPError.invalidResponse
                }
                
                let statusCode = httpResponse.statusCode
                
                guard (200..<300).contains(statusCode) else {
                    throw HTTPError.invalidStatusCode
                }
                
                return data
            }
            .eraseToAnyPublisher()
            .flatMap { data -> AnyPublisher<T, Error> in
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                return Result.Publisher(data)
                    .setFailureType(to: Error.self)
                    .decode(type: T.self, decoder: decoder)
                    .eraseToAnyPublisher()
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
