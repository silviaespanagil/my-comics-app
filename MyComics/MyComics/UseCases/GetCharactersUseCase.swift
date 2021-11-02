//
//  GetCharactersUseCase.swift
//  MyComics
//
//  Created by Xavi on 22/10/21.
//

import Foundation

class GetCharactersUseCase {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository = CharacterRepositoryImplementation()) {
        
        self.repository = repository
    }
    
    func execute() -> [Character] {
        
        return repository.getCharacters()
    }
}
