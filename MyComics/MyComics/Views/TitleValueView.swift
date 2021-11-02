//
//  TitleValueView.swift
//  MyComics
//
//  Created by Xavi on 21/10/21.
//

import SwiftUI

struct TitleValueView: View {
    
    var title: String
    
    var value: String
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            VStack(alignment: .leading) {
             
                Text(title)
                    .font(.headline)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                
                Text(value)
                    .font(.body)
            }
        }
    }
}

struct TitleValueView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        TitleValueView(title: "Title", value: "Value")
    }
}
