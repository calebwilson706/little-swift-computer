//
//  executor.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 31/03/2021.
//

import Foundation

class Executor : ObservableObject {
    
    let assembledCode : PreparedAndAssembledCode
    
    init(assembledCode : PreparedAndAssembledCode) {
        self.assembledCode = assembledCode
    }
    
    func execute() {
        
    }
    
    private func runAssembledCode(initialVariables : [DeclaredVariable]) {
        
    }
    
    
}
