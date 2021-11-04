//
//  ServerCharacterResponse.swift
//  MyComics
//
//  Created by Xavi on 19/10/21.
//

import Foundation

struct ServerCharacterResponse: Codable {
    
    let id: Int
    let name: String?
    let realName: String?
    let aliases: String?
    let image: ServerImageResponse?
    let birth: String?
    let deck: String?
    let gender: Int?
    let origin: ServerOriginResponse?
    let powers: [ServerPowerResponse]?
    
    func converToEntity() -> Character {
        
        let image = image?.converToEntity()
        
        var pows: [Power] = []
        if let serverPowers = powers {
            pows = serverPowers.map({ $0.convertToEntity()})
        }
        
        var formattedAliases = ""
        if let aliases = aliases {
            formattedAliases = aliases.replacingOccurrences(of: "\n", with: ", ")
        }
        
        return Character(id: id,
                         name: name ?? "",
                         realName: realName ?? "",
                         aliases: formattedAliases,
                         image: image,
                         birth: birth ?? "",
                         deck: deck ?? "",
                         gender: Gender(rawValue: gender ?? 0) ?? .other,
                         origin: origin?.name ?? "",
                         powers: pows)
    }
}
