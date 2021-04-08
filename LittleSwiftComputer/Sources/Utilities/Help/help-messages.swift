//
//  help-messages.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import Foundation

enum HelpMessages : String {
    case assemblyCodeEditor = "assembly-code-editor-help",
         variableDeclarationEditor = "declarations-editor-help",
         accumulator = "accumulator-help",
         output = "output-help",
         input = "input-help",
         extraSettings = "extra-settings-help",
         registers = "registers-help",
         assemblyCode = "assembly-code-help",
         instructionSetHelp = "instruction-set-help"
        
    func getHeaderForAlert() -> String {
        switch self {
        case .assemblyCodeEditor:
            return "Assembly Code Editor"
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
        case .assemblyCode:
            return "What Is Assembly Code?"
        case .instructionSetHelp:
            return "The Instruction Set"
        }
    }
    
    func getHelpText() -> String {
        if let filepath = Bundle.main.path(forResource: self.rawValue, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
                return "Cannot Load File"
            }
        }
        
        return "No Help Found"
    }
    
    func getHelpTextLines() -> Array<(offset: Int, element: String)> {
        return getHelpText().convertToEnumeratedArrayOfLines()
    }
         
}
