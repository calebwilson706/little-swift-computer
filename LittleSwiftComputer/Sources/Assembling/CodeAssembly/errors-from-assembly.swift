//
//  errors-from-assembly.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 31/03/2021.
//

import Foundation

enum AssemblyCodeErrors : Error {
    case invalidInstruction(at : Int),
         repetitionOfPlaceholder(placeholder : String),
         missingOperand(at : Int),
         noCode
    
    func getSoundFilePrefix() -> String {
        switch self {
        case .noCode:
            return "no-code"
        default:
            return "assembly"
        }
    }
}


extension AssemblyCodeErrors : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidInstruction(at: let index):
            return "There was an invalid instruction at line \(index + 1)."
        case .repetitionOfPlaceholder(placeholder: let repeatedPlaceholder):
            return "The placeholder '\(repeatedPlaceholder)' was repeated. \nPlaceholders should only be at one location."
        case .missingOperand(at : let index):
            return "The instruction at line \(index + 1) requires an operand."
        case .noCode:
            return "Please write some code to run."
        }
    }
}


