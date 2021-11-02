//
//  FavoriteListView.swift
//  MyComics
//
//  Created by Silvia España on 21/10/21.
//

import SwiftUI
import Foundation

struct FavoriteListView: View {
    
    @StateObject var viewModel: FavoriteListViewModel
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                
                ForEach(viewModel.characters) { character in
                    
                    NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))) {
                        
                        CharacterListCellView(image: character.image?.smallUrl,
                                              name: character.name,
                                              realName: character.realName)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
        }.onAppear {
            
            viewModel.getCharacters()
        }
    }
}

struct FavoriteListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        FavoriteListView(viewModel: FavoriteListViewModel())
    }
}
