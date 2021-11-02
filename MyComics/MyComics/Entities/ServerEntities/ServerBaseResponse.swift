//
//  ServerBaseResponse.swift
//  MyComics
//
//  Created by Xavi on 21/10/21.
//

import Foundation

struct ServerBaseResponse<T: Codable>: Codable {

    let results: T
}
