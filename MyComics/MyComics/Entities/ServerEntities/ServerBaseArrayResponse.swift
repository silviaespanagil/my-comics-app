//
//  ServerBaseArrayResponse.swift
//  MyComics
//
//  Created by Xavi on 18/10/21.
//

import Foundation

struct ServerBaseArrayResponse<T: Codable>: Codable {

    let results: [T]
}
