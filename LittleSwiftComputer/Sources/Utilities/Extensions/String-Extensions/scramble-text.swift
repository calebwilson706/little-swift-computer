//
//  scramble-text.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 12/04/2021.
//

import Foundation

public extension String {
    func scrambledText() -> String {
        return self.reduce("", { reworkedString, char in
            let newChar = Character(UnicodeScalar(Int.random(in: 65...122))!)
            return reworkedString + String(newChar.isLetter && char != " " ? newChar : char)
        })
    }
}
