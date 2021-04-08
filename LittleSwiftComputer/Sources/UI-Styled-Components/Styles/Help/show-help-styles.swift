//
//  show-help-styles.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 08/04/2021.
//

import SwiftUI


struct ShowHelpButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color.clear)
            .imageScale(.large)
            .foregroundColor(Color.gray)
            .showPointingHandOnHover()
    }
}

struct ShowHelpFromMainViewHeaderButtonStyle : ButtonStyle {
    let isHovering : Bool
    let onHoverCallback : (Bool) -> Void
    var foreground : Color {
        isHovering ? .white : .gray
    }
    
    func makeBody(configuration : Configuration) -> some View {
        configuration.label
            .background(Color.clear)
            .foregroundColor(foreground)
            .onHover(perform: onHoverCallback)
    }
}
