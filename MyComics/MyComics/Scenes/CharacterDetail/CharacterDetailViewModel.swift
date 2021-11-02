//
//  CharacterDetailViewModel.swift
//  MyComics
//
//  Created by Xavi on 19/10/21.
//

import SwiftUI
import Combine
import CoreData

class CharacterDetailViewModel: ObservableObject {
    
    // Variables
    
    var characterViewValue: [String] = ["Birth:", "Gender:", "Origin:", "Power:", "Description:"]
    
    let progressViewLabel: String = "Downloading"
    
    let unknownImage: String = "Unknown"
    
    public var favIcon: String = "heart"
    public var favIconFilled: String = "heart.fill"
    
    @Published public private(set) var character: Character
    
    @Published public private(set) var showProgressView = false
    
    @Published public var isFavorite : Bool = false
    
    // Cancellables
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Methods
    
    init(character: Character) {
        
        self.character = character
        
        let didSaveNotification = NSManagedObjectContext.didSaveObjectsNotification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didSave(_:)),
                                               name: didSaveNotification,
                                               object: nil)
    }
    
    @objc func didSave(_ notification: Notification) {
        
        checkIfFavorited()
    }
    
    func getCharacterDetail() {
        
        showProgressView = true
        
        cancellable = GetCharacterDetailUseCase().execute(id: character.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                self.showProgressView = false
                
                switch completion {
                case .finished:
                    break
                case .failure:
                    break
                }
                
            }, receiveValue: { (character: Character) in
                
                self.character = character
            })
    }
    
    func checkIfFavorited() {
        
        isFavorite = ExistCharacterUseCase().execute(character: character)
    }
    
    func markAsFavorite() {
        
        if isFavorite {
            
            RemoveCharacterUseCase().execute(character: character)
            
        } else {
            
            SaveCharacterUseCase().execute(character: character)
        }
    }
}
