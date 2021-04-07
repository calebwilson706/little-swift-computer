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
        print("\n\n\n")
        if let filepath = Bundle.main.path(forResource: "accumulator-help", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                print(contents)
            } catch {
                throw error
            }
        }
       
        print("\n\n\n")
    }


}
