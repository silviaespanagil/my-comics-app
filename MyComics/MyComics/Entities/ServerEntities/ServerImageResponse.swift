//
//  ServerImageResponse.swift
//  MyComics
//
//  Created by Xavi on 19/10/21.
//

import Foundation

struct ServerImageResponse: Codable {
    
    let smallUrl: String?
    let superUrl: String?
    let thumbUrl: String?
    
    func converToEntity() -> ImageModel {
        
        return ImageModel(smallUrl: smallUrl,
                          superUrl: superUrl,
                          thumbUrl: thumbUrl)
    }
}
