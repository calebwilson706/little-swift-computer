//
//  executor.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 31/03/2021.
//

import Foundation

class Executor : ObservableObject {
    
    @Published var assemblyError : AssemblyCodeErrors? = nil
    
    let assembledCode : AssembledCode
    
    init(assembledCode : AssembledCode) {
        self.assembledCode = assembledCode
    }
    
    func execute() {
        
    }
    
    func checkIfAssembledCodeIsValid() throws {
        if let indexOfFirstInvalidLine = assembledCode.indexOfFirstInvalidLine {
            throw AssemblyCodeErrors.invalidInstruction(at: indexOfFirstInvalidLine)
        }
        if let repeatedPlaceholder = assembledCode.repeatedPlaceholder {
            throw AssemblyCodeErrors.repetitionOfPlaceholder(placeholder: repeatedPlaceholder)
        }
    }
}
