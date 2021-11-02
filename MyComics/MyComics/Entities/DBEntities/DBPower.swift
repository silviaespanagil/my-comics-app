//
//  DBPower.swift
//  MyComics
//
//  Created by Xavi on 22/10/21.
//

import Foundation

extension DBPower {
    
    func convertToEntity() -> Power {
        
        return Power(id: Int(id),
                     name: name ?? "")
    }
}
