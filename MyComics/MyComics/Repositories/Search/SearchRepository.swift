//
//  SearchRepository.swift
//  MyComics
//
//  Created by Xavi on 18/10/21.
//

import Foundation
import Combine

protocol SearchRepository {
    
    func searchCharacter(searchTerm: String) -> AnyPublisher<[Character], Error>
}
