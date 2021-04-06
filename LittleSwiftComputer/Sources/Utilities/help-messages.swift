//
//  help-messages.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import Foundation

enum HelpMessages : String {
    case none = "loading...",
         assemblyCodeEditor = "a",
         variableDeclarationEditor = "b",
         accumulator = "c",
         output = "d",
         input = "e",
         extraSettings = "f",
         registers = "g"
    
    func getHeaderForAlert() -> String {
        switch self {
        case .none:
            return ""
        case .assemblyCodeEditor:
            return "Assembly Code"
        case .variableDeclarationEditor:
            return "Variable Declarations"
        case .accumulator:
            return "The Accumulator"
        case .output:
            return "Output"
        case .input:
            return "Input"
        case .extraSettings:
            return "Extra Settings"
        case .registers:
            return "Memory Registers"
        }
    }
         
}
