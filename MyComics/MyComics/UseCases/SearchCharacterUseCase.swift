//
//  SearchCharacterUseCase.swift
//  MyComics
//
//  Created by Xavi on 18/10/21.
//

import Foundation
import Combine

class SearchCharacterUseCase {
    
    private let repository: SearchRepository
    
    init(repository: SearchRepository = SearchRepositoryImplementation()) {
        
        self.repository = repository
    }
    
    func execute(searchTerm: String) -> AnyPublisher<[Character], Error> {
        
        return repository.searchCharacter(searchTerm: searchTerm)
    }
}
