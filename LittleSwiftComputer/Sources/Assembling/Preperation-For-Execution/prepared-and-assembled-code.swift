//
//  prepared-and-assembled-code.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 01/04/2021.
//

import Foundation

struct PreparedAndAssembledCode {
    let mainCodeBlock : AssembledCodeLinesUnwrapped
    let initializedVariables : [DeclaredVariable]
}

struct AssembledCodeLinesUnwrapped {
    let lines : [AssembledInstruction]
    let placeholdersForBranches : [String : Int]
}
