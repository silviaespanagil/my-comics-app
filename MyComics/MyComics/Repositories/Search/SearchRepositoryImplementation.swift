//
//  SearchRepositoryImplementation.swift
//  MyComics
//
//  Created by Xavi on 18/10/21.
//

import Foundation
import Combine
import Resolver

class SearchRepositoryImplementation: SearchRepository {
    
    private let remoteDataSource: RemoteSearchDataSource
    
    init(remoteDataSource: RemoteSearchDataSource? = nil) {
        self.remoteDataSource = remoteDataSource ?? Resolver.resolve()
    }
    
    func searchCharacter(searchTerm: String) -> AnyPublisher<[Character], Error> {
        
        return remoteDataSource.searchCharacter(searchTerm: searchTerm).map { serverCharacters -> [Character] in
            
            var characters: [Character] = []
            
            for serverCharacter in serverCharacters.results {
                
                // convert to entity
                let character = serverCharacter.converToEntity()
                
                characters.append(character)
            }
            
            // Return
            return characters
        }
        .mapError({ $0 })
        .eraseToAnyPublisher()
    }
}
