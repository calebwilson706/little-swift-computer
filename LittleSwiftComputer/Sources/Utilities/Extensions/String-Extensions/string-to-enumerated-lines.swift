//
//  string-to-enumerated-lines.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 31/03/2021.
//

import Foundation

extension String {
    func convertToEnumeratedArrayOfLinesRemoveBlanks() -> Array<(offset: Int, element: String)> {
        let validLines = self.components(separatedBy: "\n").filter { $0 != "" && $0.first != "#" }
        return Array(validLines.enumerated())
    }
    func convertToEnumeratedArrayOfLines() -> Array<(offset: Int, element: String)> {
        return Array(self.components(separatedBy: "\n").enumerated())
    }
}
