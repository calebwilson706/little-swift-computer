//
//  run-and-cancel-button-style.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 03/04/2021.
//

import Foundation
import SwiftUI

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
    let disabled : Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(BaseRunAndCancelButtonStyle(onHoverCallback : methodForHovering))
            .background((!disabled ? ComponentBackgroundColors.runButton.getColor() : Color.gray).cornerRadius(5))
    }
}

struct CancelButtonStyle : ButtonStyle {
    let methodForHovering : (Bool) -> Void
    let disabled : Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(BaseRunAndCancelButtonStyle(onHoverCallback : methodForHovering))
            .background((!disabled ? ComponentBackgroundColors.cancelButton.getColor() : Color.gray).cornerRadius(5))
    }
}
