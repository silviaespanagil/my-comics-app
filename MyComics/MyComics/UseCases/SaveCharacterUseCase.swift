//
//  SaveCharacterUseCase.swift
//  MyComics
//
//  Created by Xavi on 22/10/21.
//

import Foundation

class SaveCharacterUseCase {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository = CharacterRepositoryImplementation()) {
        
        self.repository = repository
    }
    
    func execute(character: Character) {
        
        repository.saveCharacter(character: character)
    }
}
