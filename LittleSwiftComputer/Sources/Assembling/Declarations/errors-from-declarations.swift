//
//  errors-from-declarations.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 31/03/2021.
//

import Foundation

enum DeclarationErrors : Error {
    case keywordMissing(at : Int),
         invalidIdentifier(at : Int),
         invalidOrder(at : Int)
}

extension DeclarationErrors : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .keywordMissing(at: let index):
            return "The 'dat' keyword is missing at declarations line \(index + 1)"
        case .invalidIdentifier(at: let index):
            return "The identifier used at declarations line \(index + 1) is invalid"
        case .invalidOrder(at: let index):
            return "The instruction at declarations line \(index + 1) must start with 'dat'"
        }
    }
}
