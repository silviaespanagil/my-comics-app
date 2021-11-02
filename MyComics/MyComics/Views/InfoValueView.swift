//
//  InfoValueView.swift
//  MyComics
//
//  Created by Xavi on 21/10/21.
//

import SwiftUI

struct InfoValueView: View {
    
    var info: String
    var value: String
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            VStack(alignment: .leading) {
                
                Text(info)
                    .font(.headline)
                
                Spacer().frame(height: 8)
                
                Text(value)
                    .font(.body)
            }
            
            Spacer()
        }
    }
}

struct InfoValueView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        InfoValueView(info: "Info", value: "Value")
    }
}
