//
//  ImageView.swift
//  MyComics
//
//  Created by Xavi on 19/10/21.
//

import SwiftUI

struct ImageView: View {
    
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()

        init(withURL url:String) {
            imageLoader = ImageLoader(urlString:url)
        }

        var body: some View {
            VStack {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }.onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
}

/*struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}*/
