//
//  CharacterDetailView.swift
//  MyComics
//
//  Created by Xavi on 19/10/21.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @StateObject var viewModel: CharacterDetailViewModel
 
    let width: CGFloat = 128
    let height: CGFloat = 128
    let cornerRadius: CGFloat = 10
    
    let spacing: CGFloat = 16
    let padding8: CGFloat = 8
    let padding16: CGFloat = 16
    let spacerHeight: CGFloat = 8
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            HStack(alignment: .center,spacing: spacing) {
                
                if let image = viewModel.character.image?.superUrl {
                    
                    ImageView(withURL: image)
                        .frame(width: width, height: height)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    
                } else {
                    
                    Image(viewModel.unknownImage)
                        .frame(width: width, height: height)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                }
                
                VStack(alignment: .leading, spacing: spacing) {
                    
                    Text(viewModel.character.name)
                        .font(.largeTitle)
                    
                    Text(viewModel.character.realName)
                        .font(.body)
                    
                   Button(action: {
                       
                        viewModel.markAsFavorite()
                       
                    }){
                        Spacer()
                        
                        if viewModel.isFavorite {
                           
                            Image(systemName: viewModel.favIconFilled)
                                .accessibility(label: Text("This is a favorite character"))
                                .foregroundColor(.red)
                            
                        } else {
                            
                            Image(systemName: viewModel.favIcon)
                                .accessibility(label: Text("This is not a favorite character"))
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Spacer()
            }
            
            Divider()
            
            if viewModel.showProgressView {
                
                ProgressView(viewModel.progressViewLabel)
            }
            
            ScrollView {
             
                // Birth
                
                if !viewModel.character.birth.isEmpty {
                    
                    TitleValueView(title: viewModel.characterViewValue[0],
                                   value: viewModel.character.birth)
                    
                    Spacer().frame(height: spacerHeight)
                }
                
                // Gender
                
                TitleValueView(title: viewModel.characterViewValue[1],
                               value: viewModel.character.getGender())
                
                Spacer().frame(height: spacerHeight)
                
                // Origin
                
                if !viewModel.character.origin.isEmpty {
                    
                    TitleValueView(title: viewModel.characterViewValue[2],
                                   value: viewModel.character.origin)
                    
                    Spacer().frame(height: spacerHeight)
                }
                
                // Powers
                
                if !viewModel.character.getPowers().isEmpty {
                    
                    InfoValueView(info: viewModel.characterViewValue[3],
                                  value: viewModel.character.getPowers())
                    
                    Spacer().frame(height: spacerHeight)
                }
                
                // Deck
                
                if !viewModel.character.deck.isEmpty {
                    
                    InfoValueView(info: viewModel.characterViewValue[4],
                                  value: viewModel.character.deck)
                }
            }
            .padding([.leading, .trailing], padding8)
        }
        .padding([.leading, .trailing], padding16)
        .onAppear {

            // get character detail
            viewModel.getCharacterDetail()
            
            viewModel.checkIfFavorited()
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let character = Character(id: 1,
                                  name: "Batman",
                                  realName: "Bruce Wayne",
                                  aliases: "",
                                  image: nil,
                                  birth: "",
                                  deck: "",
                                  gender: .male,
                                  origin: "",
                                  powers: [])
        
        CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))
    }
}
