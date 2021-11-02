//
//   CharacterRepositoryImplementation.swift
//  MyComics
//
//  Created by Xavi on 21/10/21.
//

import Foundation
import Combine

class CharacterRepositoryImplementation: CharacterRepository {

    private let remoteDataSource: RemoteCharacterDataSource
    private let localDataSource: LocalCharacterDataSource
    
    init(remoteDataSource: RemoteCharacterDataSource = RemoteCharacterDataSource(),
         localDataSource: LocalCharacterDataSource = LocalCharacterDataSource()) {
        
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getCharacter(id: Int) -> AnyPublisher<Character, Error> {
        
        return remoteDataSource.getCharacter(id: id).map { serverCharacter -> Character in

            // convert to entity
            let character = serverCharacter.results.converToEntity()
            
            // Return
            return character
        }
        .mapError({ $0 })
        .eraseToAnyPublisher()
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
