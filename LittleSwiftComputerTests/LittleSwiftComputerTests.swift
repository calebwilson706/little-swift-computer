//
//  LittleSwiftComputerTests.swift
//  LittleSwiftComputerTests
//
//  Created by Caleb Wilson on 30/03/2021.
//

import XCTest
@testable import LittleSwiftComputer

class LittleSwiftComputerTests: XCTestCase {
    let input = """
sta five
lda five
sub five
brz end
end out
ffrfrf
rfr
frfr add three
rfrfrf
rfrf
"""
    func testExample() throws {
        print("\n\n\n\n")
        let result = Assembler().assemble(code: input)
        result.lines.forEach { print($0 ?? "nil") }
        print()
        result.placeholdersForBranches.forEach { print($0) }
        print(result.dictionaryOfBranchesToIndices)
        print("\n\n\n\n")
    }


}
