//
//  assembly-services.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 01/04/2021.
//

import Foundation

class AssemblyServices {
    
    func prepareCodeForRunning(
        mainCodeBlock : String,
        variableBlock : String
    ) throws -> PreparedAndAssembledCode {
        do {
            let assembledCode = Assembler().assemble(code: mainCodeBlock)
            try checkIfAssembledCodeIsValid(assembledCode: assembledCode)
            let initializedVariables = try getInitializedVariables(variableDeclarationsUnparsed: variableBlock)
            
            let unwrappedAssembledCode = AssembledCodeLinesUnwrapped(
                lines: assembledCode.lines.map { $0! },
                placeholdersForBranches: assembledCode.dictionaryOfBranchesToIndices
            )
            
            if unwrappedAssembledCode.lines.count == 0 {
                throw AssemblyCodeErrors.noCode
            }
            
            return PreparedAndAssembledCode(mainCodeBlock: unwrappedAssembledCode, initializedVariables: initializedVariables)
        } catch {
            throw error
        }
    }
    
    private func checkIfAssembledCodeIsValid(assembledCode : AssembledCode) throws {
        if let indexOfFirstInvalidLine = assembledCode.indexOfFirstInvalidLine {
            throw AssemblyCodeErrors.invalidInstruction(at: indexOfFirstInvalidLine)
        }
        if let indexWithMissingOperand = assembledCode.indexOfFirstLineWithMissingRequiredOperand {
            throw AssemblyCodeErrors.missingOperand(at: indexWithMissingOperand)
        }
        if let repeatedPlaceholder = assembledCode.repeatedPlaceholder {
            throw AssemblyCodeErrors.repetitionOfPlaceholder(placeholder: repeatedPlaceholder)
        }
    }
    
    private func getInitializedVariables(variableDeclarationsUnparsed : String) throws -> [DeclaredVariable] {
        do {
            let initializedVariables = try DeclarationParser().getDeclaredVariables(declarationString: variableDeclarationsUnparsed)
            return initializedVariables
        } catch {
            throw error
        }
    }
    
}
