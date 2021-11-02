//
//  ExistCharacterUseCase.swift
//  MyComics
//
//  Created by Silvia España on 27/10/21.
//

import Foundation

class ExistCharacterUseCase {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository = CharacterRepositoryImplementation()) {
        
        self.repository = repository
    }
    
    func execute(character: Character) -> Bool {
        
        repository.existCharacter(character: character)
    }
    
}
