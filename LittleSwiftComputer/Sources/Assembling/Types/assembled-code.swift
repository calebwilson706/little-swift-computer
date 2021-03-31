//
//  assembled-code-type.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 30/03/2021.
//

import Foundation


struct AssembledCode {
    let lines : [AssembledInstruction?]
    let placeholdersForBranches : [BranchPlaceholder]
    
    var dictionaryOfBranchesToIndices : [String : Int] {
        placeholdersForBranches.reduce([String : Int](), { acc, next in
            var working = acc
            working[next.placeholderString] = next.indexOfString
            return working
        })
    }
    
    var repeatedPlaceholder : String? {
        placeholdersForBranches.first { $0.indexOfString != dictionaryOfBranchesToIndices[$0.placeholderString] }?.placeholderString
    }
    
    var indexOfFirstInvalidLine : Int? {
        lines.firstIndex { $0 == nil }
    }
}
