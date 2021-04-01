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
brz end
end out
last add three
"""
let declarations = """
dat five 5
dat three 3
dat two
dat t
"""
    func testExample() throws {
        print("\n\n\n\n")
        do {
            let code = try AssemblyServices().prepareCodeForRunning(mainCodeBlock: input, variableBlock: declarations)
            code.mainCodeBlock.lines.forEach { print($0) }
        } catch {
            print(error.localizedDescription)
        }
        print("\n\n\n\n")
    }


}
