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
        let inputLines = code.convertToEnumeratedArrayOfLinesRemoveBlanks()
        
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
        
        return AssembledCode(lines: assembledLines, placeholdersForBranches: placeholdersForBranches)
    }
    
    
    private func getOperatorFromStringCode(_ string : String) -> AssemblyOperators? {
        return AssemblyOperators.allCases.first { $0.rawValue == string }
    }
    
    private func getFullInstruction(from fullString : String) -> ParsedInstructionPair? {
        var parts = fullString.splitBySpacesAndRemoveBlanks()
        let testPart = parts.dropFirst()
        
        let locationAtStart : String? =  (parts.count == 3 || testPart.contains("out") || testPart.contains("inp")) ? parts.first : nil
        
        if locationAtStart != nil {
            parts.remove(at: 0)
        }
        
        guard let theOperator = getOperatorFromStringCode(parts.first ?? "") else {
            return nil
        }
        
        let theOperand = parts[safe : 1]?.filter { $0.isLetter }
        
        return ParsedInstructionPair(
            placeholderStringForBranch: locationAtStart,
            parsedAssemblyInstruction: AssembledInstruction(theOperator: theOperator, theOperand: (theOperand == "") ? nil : theOperand)
        )
    }
    
    private struct ParsedInstructionPair {
        let placeholderStringForBranch : String?
        let parsedAssemblyInstruction : AssembledInstruction
    }
}
