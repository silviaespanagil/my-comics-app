//
//  MockCharacterRepository.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//

import Foundation
import Combine
@testable import MyComics

class MockCharacterRepository: CharacterRepository {
    
    var isGetCharacterCalled = false
    var isSaveCharacterCalled = false
    var isRemoveCharacterCalled = false
    var isExistCharacterCalled = false
    var isGetCharactersCalled = false
    
    func getCharacter(id: Int) -> AnyPublisher<Character, Error> {
     
        self.isGetCharacterCalled = true
        
        return Just(Character(id: 1, name: "", realName: "", aliases: "", image: nil, birth: "", deck: "", gender: .female, origin: "", powers: []))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func saveCharacter(character: Character) {
        
        self.isSaveCharacterCalled = true
    }
    
    func removeCharacter(character: Character) {
        
        self.isRemoveCharacterCalled = true
    }
    
    func existCharacter(character: Character) -> Bool {
        
        self.isExistCharacterCalled = true
        
        return true
    }
    
    func getCharacters() -> [Character] {
        
        self.isGetCharactersCalled = true
        
        return []
    }
}
