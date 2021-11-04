//
//  DBManager.swift
//  MyComics
//
//  Created by Xavi on 22/10/21.
//

import Foundation
import CoreData

class DBManager: Persistence {
    
    
    // MARK: - Properties
    
    let coreDataStack: CoreDataStack
    
    // MARK: - Methods
    
    init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
        
        self.coreDataStack = coreDataStack
    }
    
    func saveCharacter(character: Character) {
        
        let dbImage = DBImage(context: coreDataStack.managedContext)
        dbImage.id = UUID()
        dbImage.smallUrl = character.image?.smallUrl
        dbImage.superUrl = character.image?.superUrl
        dbImage.thumbUrl = character.image?.thumbUrl
        
        var dbPowers: [DBPower] = []
        for power in character.powers {
            let dbPower = DBPower(context: coreDataStack.managedContext)
            dbPower.id = Int32(power.id)
            dbPower.name = power.name
            dbPowers.append(dbPower)
        }
        
        let dbCharacter = DBCharacter(context: coreDataStack.managedContext)
        dbCharacter.id = Int32(character.id)
        dbCharacter.name = character.name
        dbCharacter.realName = character.realName
        dbCharacter.aliases = character.aliases
        dbCharacter.birth = character.birth
        dbCharacter.deck = character.deck
        dbCharacter.gender = Int16(character.gender.rawValue)
        dbCharacter.origin = character.origin
        
        dbCharacter.image = dbImage
        dbCharacter.powers?.addingObjects(from: dbPowers)
        
        coreDataStack.saveContext()
    }
    
    func removeCharacter(character: Character) {
        
        let characterId = Int32(character.id)

        let fetchRequest = NSFetchRequest<DBCharacter>(entityName: "DBCharacter")
        fetchRequest.predicate = NSPredicate(format: "id==\(characterId)")
        do {
        
            let dbCharacters = try coreDataStack.managedContext.fetch(fetchRequest)

            for dbCharacter in dbCharacters {
                coreDataStack.managedContext.delete(dbCharacter)
            }

            coreDataStack.saveContext()

        } catch let error as NSError {
        
            print("Could not fetch for delete. \(error), \(error.userInfo)")
        }
    }
    
    func existCharacter(character: Character) -> Bool {
        
        let characterId = Int32(character.id)
        
        let fetchRequest = NSFetchRequest<DBCharacter>(entityName: "DBCharacter")
        fetchRequest.predicate = NSPredicate(format: "id==\(characterId)")
        
        do {
            
            let dbCharacters = try coreDataStack.managedContext.fetch(fetchRequest)
            
            return dbCharacters.first != nil
            
        } catch let error as NSError {
            
            print("Could not fetch for delete. \(error), \(error.userInfo)")
            
            return false
        }
    }
    
    func getCharacters() -> [Character] {
        
        var characters: [Character] = []
        
        let fetchRequest = NSFetchRequest<DBCharacter>(entityName: "DBCharacter")
        
        do {
            
            let dbCharacters = try coreDataStack.managedContext.fetch(fetchRequest)
            
            for dbCharacter in dbCharacters {
                let character = dbCharacter.convertToEntity()
                characters.append(character)
            }
            
        } catch let error as NSError {
            
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return characters
    }
    
    func getCharacter(id: Int) -> Character? {
        
        let characterId = Int32(id)
        
        let fetchRequest = NSFetchRequest<DBCharacter>(entityName: "DBCharacter")
        fetchRequest.predicate = NSPredicate(format: "id==\(characterId)")
        
        do {
            
            let dbCharacters = try coreDataStack.managedContext.fetch(fetchRequest)
            
            if let dbCharacter = dbCharacters.first {
                
                return dbCharacter.convertToEntity()
                
            } else {
                
                return nil
            }
            
        } catch let error as NSError {
            
            print("Could not fetch character id. \(error), \(error.userInfo)")
            
            return nil
        }
    }
}
