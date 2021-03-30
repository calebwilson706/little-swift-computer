//
//  safe-array-access.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 30/03/2021.
//

import Foundation

extension Collection {
    subscript (safe index : Index) -> Element? {
        return (self.indices.contains(index) ? self[index] : nil)
    }
}
