//
//  TestCoreDataStack.swift
//  MyComicsTests
//
//  Created by Xavi on 22/10/21.
//

import Foundation
import CoreData
@testable import MyComics

class TestCoreDataStack: CoreDataStack {
    
    private let modelName = "Model"
    
    override init() {
        
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: modelName)
        
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        storeContainer = container
    }
}
