//
//   CharacterRepository.swift
//  MyComics
//
//  Created by Xavi on 21/10/21.
//

import Foundation
import Combine

protocol CharacterRepository {
    
    func getCharacter(id: Int) -> AnyPublisher<Character, Error>
    
    func saveCharacter(character: Character)
    func removeCharacter(character: Character)
    func existCharacter(character: Character) -> Bool
    func getCharacters() -> [Character]
}
