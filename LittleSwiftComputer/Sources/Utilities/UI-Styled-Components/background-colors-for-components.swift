//
//  background-colors-for-components.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 05/04/2021.
//

import Foundation
import SwiftUI

enum ComponentBackgroundColors {
    case accumulator,
         output,
         inputTextField,
         runButton,
         cancelButton
    
    func getColor() -> Color {
        switch self {
        case .accumulator, .inputTextField:
            return Color(red: 147.convertToRGBValue(), green: 99.convertToRGBValue(), blue: 207.convertToRGBValue())
        case .output :
            return Color.gray
        case .runButton:
            return Color(red: 61.convertToRGBValue(), green: 166.convertToRGBValue(), blue: 66.convertToRGBValue())
        case .cancelButton:
            return Color(red : 166.convertToRGBValue(), green: 61.convertToRGBValue(), blue: 66.convertToRGBValue())
        }
    }
}
