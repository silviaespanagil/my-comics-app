//
//  CharacterListCellView.swift
//  MyComics
//
//  Created by Xavi on 19/10/21.
//

import SwiftUI

struct CharacterListCellView: View {
    
    var image: String?
    var name: String
    var realName: String
    
    let width: CGFloat = 48
    let height: CGFloat = 48
    let cornerRadius: CGFloat = 10
    
    let spacing: CGFloat = 8
    let padding: CGFloat = 8
    
    init(image: String?, name: String, realName: String) {
        self.image = image
        self.name = name
        self.realName = realName
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {

            HStack(spacing: spacing) {
                
                if let image = image {
                    
                    ImageView(withURL: image)
                        .frame(width: width, height: height)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    
                } else {
                    
                    Image("unknown")
                        .frame(width: width, height: height)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                }
                
                VStack(alignment: .leading) {
                    
                    Text(name)
                        .font(.headline)
                    
                    Text(realName)
                        .font(.subheadline)
                }
                
                Spacer()
            }
           
            Divider()
            
        }.padding([.leading, .trailing], padding)
        .background(Color.white)
    }
}

struct CharacterListCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CharacterListCellView(image: nil,
                              name: "Batman",
                              realName: "Bruce Wayne")
    }
}
