//
//  Gender.swift
//  MyComics
//
//  Created by Xavi on 18/10/21.
//

import Foundation

enum Gender: Int, CaseIterable {
    case other, male, female
    
    var description: String {
        switch self {
        case .other:
            return "Other"
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}
