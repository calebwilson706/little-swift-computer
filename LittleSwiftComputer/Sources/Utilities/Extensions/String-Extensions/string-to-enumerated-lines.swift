//
//  string-to-enumerated-lines.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 31/03/2021.
//

import Foundation

extension String {
    func convertToEnumeratedArrayOfLinesRemoveBlanks() -> Array<(offset: Int, element: String)> {
        return convertToEnumeratedArrayOfLines().filter { $0.element != "" && $0.element.first != "#" }
    }
    func convertToEnumeratedArrayOfLines() -> Array<(offset: Int, element: String)> {
        return Array(self.components(separatedBy: "\n").enumerated())
    }
}
