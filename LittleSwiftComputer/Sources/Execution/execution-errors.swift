//
//  execution-errors.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 01/04/2021.
//

import Foundation

enum ExecutionErrors : Error {
    case undeclaredVariableAccess(at : Int),
         missingPlaceholder(at : Int),
         requiresInput
    
    func getFileNameForAudioPlayer() -> String {
        let postfix = "-sound.mp3"
        
        switch self {
        case .requiresInput:
            return "input-required" + postfix
        default:
            return "run-time-error" + postfix
        }
        
    }
}


extension ExecutionErrors : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .undeclaredVariableAccess(at: let at):
            return "You tried to access an undeclared variable at line \(at + 1)"
        case .missingPlaceholder(at: let at):
            return "At line \(at + 1) you tried to move to a missing placeholder."
        case .requiresInput:
            return "Program requires input!"
        }
    }
}
