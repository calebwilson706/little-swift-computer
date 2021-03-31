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
frfr sub two
out
frfr brz end
end out
last add three
"""
    func testExample() throws {
        print("\n\n\n\n")
        let result = Assembler().assemble(code: input)
        let executor = Executor(assembledCode: result, variableDeclarationsUnparsed: """
dat five 5
dat three 3
dat two
dat t
""")
        executor.execute()
        print(executor.errorMessageString ?? "continue")
        print("\n\n\n\n")
    }


}
