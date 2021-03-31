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
frfr brz end
end out
last add three
"""
    func testExample() throws {
        print("\n\n\n\n")
        let result = Assembler().assemble(code: input)
        let executor = Executor(assembledCode: result, variableDeclarationsUnparsed: "da five 5")
        executor.execute()
        print("\n\n\n\n")
    }


}
