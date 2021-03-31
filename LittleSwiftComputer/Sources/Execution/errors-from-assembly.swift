//
//  errors-from-assembly.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 31/03/2021.
//

import Foundation

enum AssemblyCodeErrors : Error {
    case invalidInstruction(at : Int),
         repetitionOfPlaceholder(placeholder : String)
}


extension AssemblyCodeErrors : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidInstruction(at: let indexOfInvalid):
            return "There was an invalid instruction at line \(indexOfInvalid + 1)"
        case .repetitionOfPlaceholder(placeholder: let repeatedPlaceholder):
            return "The placeholder '\(repeatedPlaceholder)' was repeated. Placeholders should only be at one location."
        }
    }
}


