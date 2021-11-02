//
//  GetCharacterDetailUseCase.swift
//  MyComics
//
//  Created by Xavi on 21/10/21.
//

import Foundation
import Combine

class GetCharacterDetailUseCase {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository = CharacterRepositoryImplementation()) {
        
        self.repository = repository
    }
    
    func execute(id: Int) -> AnyPublisher<Character, Error> {
        
        return repository.getCharacter(id: id)
    }
}
