//
//  FavoriteListViewModel.swift
//  MyComics
//
//  Created by Xavi on 22/10/21.
//

import Foundation
import SwiftUI

class FavoriteListViewModel: ObservableObject {
    
    // Values
    
    @Published public private(set) var characters: [Character] = []
 
    // MARK: - Methods
    
    func getCharacters() {
        
        characters = GetCharactersUseCase().execute()
    }
}
