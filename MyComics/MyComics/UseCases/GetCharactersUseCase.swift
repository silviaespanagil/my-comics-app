//
//  GetCharactersUseCase.swift
//  MyComics
//
//  Created by Xavi on 22/10/21.
//

import Foundation
import Resolver

class GetCharactersUseCase {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository? = nil) {
           
           self.repository = repository ?? Resolver.resolve()
       }
    
    func execute() -> [Character] {
        
        return repository.getCharacters()
    }
}
