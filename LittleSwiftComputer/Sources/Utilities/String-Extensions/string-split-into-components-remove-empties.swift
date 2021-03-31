//
//  string-split-into-components-remove-empties.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 31/03/2021.
//

import Foundation

extension String {
    func splitBySpacesAndRemoveBlanks() -> [String] {
        self.components(separatedBy: .whitespaces).filter { $0 != "" }
    }
}
