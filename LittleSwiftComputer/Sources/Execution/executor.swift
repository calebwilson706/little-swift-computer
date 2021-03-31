//
//  executor.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 31/03/2021.
//

import Foundation

class Executor : ObservableObject {
    
    @Published var errorMessageString : String? = nil
    
    let assembledCode : AssembledCode
    let variableDeclarationsUnparsed : String
    
    init(assembledCode : AssembledCode, variableDeclarationsUnparsed : String) {
        self.assembledCode = assembledCode
        self.variableDeclarationsUnparsed = variableDeclarationsUnparsed
    }
    
    func execute() {
        do {
            try checkIfAssembledCodeIsValid()
            let initializedVariables = try getInitializedVariables()
            runAssembledCode(initialVariables: initializedVariables)
        } catch {
            errorMessageString = error.localizedDescription
            return
        }
    }
    
    private func runAssembledCode(initialVariables : [DeclaredVariable]) {
        
    }
    
    private func checkIfAssembledCodeIsValid() throws {
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
    
    private func getInitializedVariables() throws -> [DeclaredVariable] {
        do {
            let initializedVariables = try DeclarationParser().getDeclaredVariables(declarationString: variableDeclarationsUnparsed)
            return initializedVariables
        } catch {
            throw error
        }
    }
}
