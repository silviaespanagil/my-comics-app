//
//  MockSearchRepository.swift
//  MyComicsTests
//
//  Created by Xavi on 18/10/21.
//

import Foundation
import Combine
@testable import MyComics

class MockSearchRepository: SearchRepository {
    
    var isSearchCalled: Bool = false
    
    func searchCharacter(searchTerm: String) -> AnyPublisher<[Character], Error> {
        
        isSearchCalled = true
        
        return Just([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
