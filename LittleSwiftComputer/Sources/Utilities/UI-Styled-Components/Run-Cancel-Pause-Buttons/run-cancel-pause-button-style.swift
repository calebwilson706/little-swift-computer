//
//  run-and-cancel-button-style.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 03/04/2021.
//

import Foundation
import SwiftUI

struct BaseRunPauseCancelButtonStyle : ViewModifier {
    let onHoverCallback : (Bool) -> Void
    let component : ComponentBackgroundColors
    let disabled : Bool
    
    func body(content: Content) -> some View {
        return content
            .frame(minWidth : 20)
            .frame(height : 20)
            .padding(.vertical, 3)
            .padding(.horizontal, 6)
            .imageScale(.small)
            .background((!disabled ? component.getColor() : Color.gray).cornerRadius(5))
            .onHover { inside in
                onHoverCallback(inside)
            }
    }
}

struct ControlFlowButtonStyle : ButtonStyle {
    let methodForHovering : (Bool) -> Void
    let disabled : Bool
    let component : ComponentBackgroundColors
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(BaseRunPauseCancelButtonStyle(onHoverCallback : methodForHovering,component: component, disabled: disabled))
    }
}
