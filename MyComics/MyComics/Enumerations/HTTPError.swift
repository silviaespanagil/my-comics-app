//
//  HTTPError.swift
//  MyComics
//
//  Created by Xavi on 18/10/21.
//

import Foundation

enum HTTPError: LocalizedError, Equatable {
    case invalidResponse
    case invalidStatusCode
}
