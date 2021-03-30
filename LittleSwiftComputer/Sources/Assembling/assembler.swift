//
//  assembler.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 30/03/2021.
//

import Foundation


class Assembler {
    
    func assemble(code : String) -> AssembledCode {
        var assembledLines = [AssembledInstruction?]()
        var placeholdersForBranches = [BranchPlaceholder]()
        let inputLines = Array(code.components(separatedBy: .newlines).enumerated())
        
        inputLines.forEach { index, element in
            let (placeholderLocation, instruction) = getFullInstruction(from: element)
            assembledLines.append(instruction)
            
            if let newPlaceholderString = placeholderLocation {
                placeholdersForBranches.append(
                    BranchPlaceholder(
                        index : index,
                        string : newPlaceholderString
                    )
                )
            }
        }
        
        assembledLines = replaceInvalidInstructionsWithNil(from: assembledLines)
        return AssembledCode(lines: assembledLines, placeholdersForBranches: placeholdersForBranches)
        
    }
    
    
    private func getOperatorFromStringCode(_ string : String) -> AssemblyOperators? {
        return AssemblyOperators.allCases.first { $0.rawValue == string }
    }
    
    private func getFullInstruction(from fullString : String) -> (String?, AssembledInstruction?) {
        var parts = fullString.components(separatedBy: " ")
        
        let locationAtStart : String? =  (parts.count == 3 || parts.contains("out")) ? parts.first : nil
        
        if locationAtStart != nil {
            parts.remove(at: 0)
        }
        
        guard let theOperator = getOperatorFromStringCode(parts.first ?? "") else {
            return (nil, nil)
        }
        
        let theOperand = parts[safe : 1]
        
        return (locationAtStart, AssembledInstruction(theOperator: theOperator, theOperand: theOperand))
    }
    
    private func replaceInvalidInstructionsWithNil(from list : [AssembledInstruction?]) -> [AssembledInstruction?] {
        return list.map {
            if ($0?.isInstructionValid() ?? true) {
                return $0
            } else {
                return nil
            }
        }
    }
    
}
