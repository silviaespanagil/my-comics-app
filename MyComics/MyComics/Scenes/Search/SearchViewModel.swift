//
//  SearchViewModel.swift
//  MyComics
//
//  Created by Xavi on 19/10/21.
//

import Foundation
import SwiftUI
import Combine
import Resolver

class SearchViewModel: ObservableObject {

    // Values
    
    let title: String
    var textLabel: String
    let button: String
    let progressLabel: String
    
    private var originalCharacters: [Character] = []
    
    @Published public private(set) var genderFilter = ["Other", "Male", "Female", "All genders"]
    
    @Published public private(set) var characters: [Character] = []
    
    @Published public private(set) var showProgressView = false
    
    @Published public private(set) var searchDone = false
    
    private var searchCharacterUseCase: SearchCharacterUseCase = Resolver.resolve()
    
    // Cancellables
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Methods
    
    init() {
        
        title = "My Comics"
        textLabel = "Search here: "
        button = "Search"
        progressLabel = "Searching..."
    }
    
    func search(searchInput: String) {
        
        showProgressView = true
        
        cancellable = searchCharacterUseCase.execute(searchTerm: searchInput)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                self.showProgressView = false
                self.searchDone = true
                
                switch completion {
                case .finished:
                    break
                case .failure:
                    break
                }
                
            }, receiveValue: { (characters: [Character]) in
                
                self.originalCharacters = characters
                self.characters = characters
            })
    }
    
    func filterByGender(_ selection: Int) {
        
        if selection == genderFilter.count - 1 {
            
            // ALl values
            self.characters = self.originalCharacters
            
        } else {
            
            self.characters = self.originalCharacters.filter { character in
                
                character.gender.rawValue == selection
            }
        }
    }
    
    func deleteSearchInput() {
        
        self.originalCharacters = []
        self.characters = []
        self.searchDone = false
    }
}
