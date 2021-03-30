//
//  LittleSwiftComputerTests.swift
//  LittleSwiftComputerTests
//
//  Created by Caleb Wilson on 30/03/2021.
//

import XCTest
@testable import LittleSwiftComputer

class LittleSwiftComputerTests: XCTestCase {

    func testExample() throws {
        print("\n\n\n\n")
        print(
        Assembler().assemble(code: """
add 5
sub 10
lda seven
next out
bra next
hehhe
e2uef
add idh
"""))
        
        print("\n\n\n\n")
    }


}
