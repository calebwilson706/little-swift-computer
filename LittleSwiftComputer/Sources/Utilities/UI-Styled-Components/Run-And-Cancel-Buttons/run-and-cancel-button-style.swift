//
//  run-and-cancel-button-style.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 03/04/2021.
//

import Foundation
import SwiftUI

private let greenColorForRunButton = Color(red: 61.convertToRGBValue(), green: 166.convertToRGBValue(), blue: 66.convertToRGBValue())

private let redColorForCancelButton = Color(red : 166.convertToRGBValue(), green: 61.convertToRGBValue(), blue: 66.convertToRGBValue())



private struct BaseRunAndCancelButtonStyle : ViewModifier {
    let onHoverCallback : (Bool) -> Void
    
    func body(content: Content) -> some View {
        return content
            .frame(minWidth : 20)
            .frame(height : 20)
            .padding(.vertical, 3)
            .padding(.horizontal, 6)
            .imageScale(.small)
            .onHover { inside in
                onHoverCallback(inside)
            }
    }
}

struct RunButtonStyle : ButtonStyle {
    let methodForHovering : (Bool) -> Void
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(BaseRunAndCancelButtonStyle(onHoverCallback : methodForHovering))
            .background(greenColorForRunButton.cornerRadius(5))
    }
}

struct CancelButtonStyle : ButtonStyle {
    let methodForHovering : (Bool) -> Void
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(BaseRunAndCancelButtonStyle(onHoverCallback : methodForHovering))
            .background(redColorForCancelButton.cornerRadius(5))
    }
}
