//
//  ChangeHelpButtonPair.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 08/04/2021.
//

import Foundation

struct ChangeHelpButtonProperties {
    let helpBeingChangedTo : HelpMessages
    
    var labelOfButtonWhichChangesToThis : String {
        switch helpBeingChangedTo {
        case .assemblyCodeEditor:
            return "Write some assembly code."
        case .registers:
            return "Learn about registers."
        case .variableDeclarationEditor:
            return "How do declarations work?"
        default:
            return "Tell me more."
        }
    }
    
    init(_ helpBeingChangedTo : HelpMessages){
        self.helpBeingChangedTo = helpBeingChangedTo
    }
}


extension HelpMessages {
    func partner() -> ChangeHelpButtonProperties? {
        switch self {
        case .assemblyCodeEditor:
            return ChangeHelpButtonProperties(.assemblyCode)
        case .assemblyCode:
            return ChangeHelpButtonProperties(.assemblyCodeEditor)
        case .variableDeclarationEditor:
            return ChangeHelpButtonProperties(.registers)
        case .registers:
            return ChangeHelpButtonProperties(.variableDeclarationEditor)
        default:
            return nil
        }
    }
}
