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
        let inputLines = code.convertToEnumeratedArrayOfLines()
        
        inputLines.forEach { index, lineOfCode in
            let parsedInstructionLine = getFullInstruction(from: lineOfCode)
            assembledLines.append(parsedInstructionLine?.parsedAssemblyInstruction)
            
            if let newPlaceholderString = parsedInstructionLine?.placeholderStringForBranch {
                placeholdersForBranches.append(
                    BranchPlaceholder(
                        indexOfString : index,
                        placeholderString : newPlaceholderString
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
    
    private func getFullInstruction(from fullString : String) -> ParsedInstructionPair? {
        var parts = fullString.components(separatedBy: .whitespaces)
        
        let locationAtStart : String? =  (parts.count == 3 || parts.contains("out")) ? parts.first : nil
        
        if locationAtStart != nil {
            parts.remove(at: 0)
        }
        
        guard let theOperator = getOperatorFromStringCode(parts.first ?? "") else {
            return nil
        }
        
        let theOperand = parts[safe : 1]
        
        return ParsedInstructionPair(
            placeholderStringForBranch: locationAtStart,
            parsedAssemblyInstruction: AssembledInstruction(theOperator: theOperator, theOperand: theOperand)
        )
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
    
    private struct ParsedInstructionPair {
        let placeholderStringForBranch : String?
        let parsedAssemblyInstruction : AssembledInstruction
    }
}
