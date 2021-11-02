//
//  ServerPowerResponse.swift
//  MyComics
//
//  Created by Xavi on 21/10/21.
//

import Foundation

struct ServerPowerResponse: Codable {
    
    let id: Int
    let name: String?
    
    func convertToEntity() -> Power {
        
        return Power(id: id,
                     name: name ?? "")
    }
}
