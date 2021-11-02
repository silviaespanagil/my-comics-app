//
//  RemoveCharacterUseCase.swift
//  MyComics
//
//  Created by Xavi on 22/10/21.
//

import Foundation

class RemoveCharacterUseCase {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository = CharacterRepositoryImplementation()) {
        
        self.repository = repository
    }
    
    func execute(character: Character) {
        
        repository.removeCharacter(character: character)
    }
}
