//
//  LocalCharacterDataSource.swift
//  MyComics
//
//  Created by Xavi on 22/10/21.
//

import Foundation

class LocalCharacterDataSource {
    
    private let dbManager: Persistence
    
    init(dbManager: Persistence = DBManager()) {
        
        self.dbManager = dbManager
    }
    
    func saveCharacter(character: Character) {
        
        dbManager.saveCharacter(character: character)
    }
    
    func removeCharacter(character: Character) {
        
        dbManager.removeCharacter(character: character)
    }
    
    func existCharacter(character: Character) -> Bool {
        
        dbManager.existCharacter(character: character)
    }
    
    func getCharacters() -> [Character] {
        
        dbManager.getCharacters()
    }
}
