//
//  background-colors-for-components.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 05/04/2021.
//

import Foundation
import SwiftUI

enum ComponentMetaData {
    case accumulator,
         output,
         inputTextField,
         runButton,
         pauseButton,
         resumeButton,
         cancelButton,
         errorMessage,
         inputRequiredMessage,
         helpAlert,
         highlightedHelpText,
         changeHelpButton
    
    func getColor() -> Color {
        switch self {
        case .accumulator, .inputTextField:
            return Color(red: 147.convertToRGBValue(), green: 99.convertToRGBValue(), blue: 207.convertToRGBValue())
        case .output :
            return Color.gray
        case .runButton:
            return Color(red: 61.convertToRGBValue(), green: 166.convertToRGBValue(), blue: 66.convertToRGBValue())
        case .pauseButton, .resumeButton:
            return Color.blue
        case .cancelButton, .errorMessage:
            return Color(red : 166.convertToRGBValue(), green: 61.convertToRGBValue(), blue: 66.convertToRGBValue())
        case .inputRequiredMessage:
            return Color(red: 10.convertToRGBValue(), green: 79.convertToRGBValue(), blue: 14.convertToRGBValue())
        case .helpAlert:
            return Color(red: 46.convertToRGBValue(), green: 46.convertToRGBValue(), blue: 46.convertToRGBValue())
        case .highlightedHelpText, .changeHelpButton:
            return Color(red: 5.convertToRGBValue(), green: 168.convertToRGBValue(), blue: 144.convertToRGBValue())
        }
    }
    
    func getImageStringForComponent() -> String? {
        switch self {
        case .runButton, .resumeButton:
            return "play.fill"
        case .pauseButton:
            return "pause.fill"
        case .cancelButton:
            return "square.fill"
        default:
            return nil
        }
    }
}
