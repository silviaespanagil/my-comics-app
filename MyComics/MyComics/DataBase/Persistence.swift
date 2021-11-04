//
//  Persistence.swift
//  MyComics
//
//  Created by Xavi on 22/10/21.
//

import Foundation

protocol Persistence {
    
    /**
        Save character to DB
     */
    func saveCharacter(character: Character)
    
    /**
        Remove character from DB
     */
    func removeCharacter(character: Character)
    
    /**
        Existe character in DB
     */
   func existCharacter(character: Character) -> Bool
    
    /**
        Get all characters from DB
     */
    func getCharacters() -> [Character]
    
    /**
        Get Character by specified id if found
     */
    func getCharacter(id: Int) -> Character?
}
