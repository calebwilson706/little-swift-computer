//
//  assembled-instruction.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 30/03/2021.
//

import Foundation

struct AssembledInstruction {
    let theOperator : AssemblyOperators
    var theOperand : String?
    
    init(theOperator : AssemblyOperators, theOperand : String? = nil) {
        self.theOperator = theOperator
        self.theOperand = theOperand?.filter { $0.isNumber || $0.isLetter }
        
        if self.theOperand?.count == 0 {
            self.theOperand = nil
        }
        
    }
    
    func isInstructionValid() -> Bool {
        switch theOperator {
        case .output, .halt, .input   :
            return true
        default :
            return (theOperand != nil)
        }
    }
    
}
