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
         //operands below have no operand
         output = "out",
         halt = "hlt",
         //operands for those below will be placeholders
         branch_always = "bra",
         branch_if_zero = "brz",
         branch_if_positive = "brp"
         
}
