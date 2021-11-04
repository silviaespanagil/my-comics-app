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
    
    enum State: Equatable {
        case idle
        case loading
        case failed
        case success
    }
    
    // Variables
    
    var characterViewValue: [String] = ["Birth:", "Gender:", "Origin:", "Alias:", "Power:", "Description:"]
    
    let progressViewLabel: String = "Downloading"
    
    let unknownImage: String = "Unknown"
    
    public var favIcon: String = "heart"
    public var favIconFilled: String = "heart.fill"
    
    @Published public private(set) var character: Character
    
    @Published public var isFavorite : Bool = false
    
    @Published private(set) var state: State = State.idle
    
    // Cancellables
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Methods
    
    init(character: Character) {
        
        self.character = character
    }
    
    func getCharacterDetail() {
        
        state = .loading
        
        cancellable = GetCharacterDetailUseCase().execute(id: character.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .finished:
                    self.state = .success
                case .failure:
                    self.state = .failed
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
        
        checkIfFavorited()
    }
}
