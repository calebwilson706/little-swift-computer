//
//  convert-rgb-value.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 03/04/2021.
//

import Foundation

extension Int {
    func convertToRGBValue() -> Double {
        return Double(self)/255.0
    }
}
