//
//  SearchCharacterUseCase.swift
//  MyComics
//
//  Created by Xavi on 18/10/21.
//

import Foundation
import Combine
import Resolver

class SearchCharacterUseCase {
    
    private let repository: SearchRepository
    
    init(repository: SearchRepository? = nil) {
           self.repository = repository ?? Resolver.resolve()
       }
    
    func execute(searchTerm: String) -> AnyPublisher<[Character], Error> {
        
        return repository.searchCharacter(searchTerm: searchTerm)
    }
}
