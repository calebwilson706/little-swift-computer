//
//  execution-errors.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 01/04/2021.
//

import Foundation

enum ExecutionErrors : Error {
    case undeclaredVariableAccess(at : Int),
         runningForToLong,
         missingPlaceholder(at : Int)
}


extension ExecutionErrors : LocalizedError {
    var errorDescription: String? {
        switch self {
        
        case .undeclaredVariableAccess(at: let at):
            return "You tried to access an undeclared variable at line \(at + 1)"
        case .runningForToLong:
            return "Your program was running for too long so the computer got worried and stopped."
        case .missingPlaceholder(at: let at):
            return "At line \(at + 1) you tried to move to a missing placeholder."
        }
    }
}
