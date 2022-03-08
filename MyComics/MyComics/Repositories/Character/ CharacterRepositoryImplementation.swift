//
//   CharacterRepositoryImplementation.swift
//  MyComics
//
//  Created by Xavi on 21/10/21.
//

import Foundation
import Combine
import Resolver

class CharacterRepositoryImplementation: CharacterRepository {

    private let remoteDataSource: RemoteCharacterDataSource
    private let localDataSource: LocalCharacterDataSource
    
    init(localDataSource: LocalCharacterDataSource? = nil,
         remoteDataSource: RemoteCharacterDataSource? = nil) {
        self.localDataSource = localDataSource ?? LocalCharacterDataSource()
        self.remoteDataSource = remoteDataSource ?? Resolver.resolve()
    }
    
    func getCharacter(id: Int) -> AnyPublisher<Character, Error> {
        
        if let character = localDataSource.getCharacter(id: id) {
            
            return Just(character)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            
        } else {
        
            return remoteDataSource.getCharacter(id: id).map { serverCharacter -> Character in
                
                // convert to entity
                let character = serverCharacter.results.converToEntity()
                
                // Return
                return character
            }
            .mapError({ $0 })
            .eraseToAnyPublisher()
        }
    }
    
    func saveCharacter(character: Character) {
        
        return localDataSource.saveCharacter(character: character)
    }
    
    func removeCharacter(character: Character) {
        
        return localDataSource.removeCharacter(character: character)
    }
    
    func existCharacter(character: Character) -> Bool {
        
        return localDataSource.existCharacter(character: character)
    }
    
    func getCharacters() -> [Character] {
        
        return localDataSource.getCharacters()
    }
}
