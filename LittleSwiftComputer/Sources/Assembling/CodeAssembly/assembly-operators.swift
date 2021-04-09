//
//  assembly-operators.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 30/03/2021.
//

import Foundation

enum AssemblyOperators : String, CaseIterable {
    case add = "add",
         subtract = "sub",
         store = "sta",
         load = "lda",
         //operands for those below is optional
         output = "out",
         input = "inp",
         //no operand for halt
         halt = "hlt",
         //operands for those below will be placeholders
         branch_always = "bra",
         branch_if_zero = "brz",
         branch_if_positive = "brp"
    
    func requiresIncrementation() -> Bool {
        [.add, .subtract, .store, .load, .output].contains(self)
    }
         
}
