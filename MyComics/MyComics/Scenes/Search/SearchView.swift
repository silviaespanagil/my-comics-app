//
//  SearchView.swift
//  MyComics
//
//  Created by Xavi on 19/10/21.
//

import SwiftUI
import Resolver

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchViewModel = Resolver.resolve()
    
    @State var searchText: String = ""
    
    @State private var selection = 3
    
    var body: some View {
        
        VStack() {
            
            HStack(spacing: 8) {
                
                TextField(viewModel.textLabel, text: $searchText)
                
                if !searchText.isEmpty {
                    
                    Button(action: {
                        
                        self.searchText = ""
                        viewModel.deleteSearchInput()
                    }){
                        
                        Image(systemName: "delete.left")
                        .foregroundColor(.gray)
                    }
                }
                
                Button(viewModel.button) {
                    
                    if !searchText.isEmpty {
                        
                        selection = 3
                        
                        viewModel.search(searchInput: searchText)
                    }
                }
            }
            
            Divider()
            
            // Filter by Gender only when a search is displayed
            
            if viewModel.searchDone {
                
                VStack{
                    
                    HStack{
                        
                        Spacer()
                        
                        Picker(selection: $selection, label: Text("")) {
                            
                            ForEach(0 ..< viewModel.genderFilter.count, content: { index in
                                
                                Text(self.viewModel.genderFilter[index])
                                    .tag(index)
                            })
                            
                        }.onChange(of: selection) { _ in
                            
                            viewModel.filterByGender(selection)
                        }
                    }
                }
            }
            
            if viewModel.showProgressView {
                
                ProgressView(viewModel.progressLabel)
            }
            
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
        }
        .padding(.top, 8)
        .padding([.leading, .trailing], 16)
    }
}

struct SearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        SearchView()
    }
}
