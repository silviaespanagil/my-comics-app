//
//  DBImage.swift
//  MyComics
//
//  Created by Xavi on 22/10/21.
//

import Foundation

extension DBImage {
    
    func convertToEntity() -> ImageModel {
        
        return ImageModel(smallUrl: smallUrl ?? "",
                          superUrl: superUrl ?? "",
                          thumbUrl: thumbUrl ?? "")
    }
}
