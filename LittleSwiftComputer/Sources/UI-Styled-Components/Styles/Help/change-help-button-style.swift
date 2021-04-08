//
//  change-help-button-style.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 08/04/2021.
//

import SwiftUI

struct ChangeHelpButtonStyle : ButtonStyle {
    let isHoveringOnButton : Bool
    let onHoverCallback : (Bool) -> Void
    
    var background : Color {
        isHoveringOnButton ? Color.white : ComponentMetaData.changeHelpButton.getColor()
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 5)
            .padding(.horizontal, 8)
            .foregroundColor(Color.black)
            .background(background.cornerRadius(7.5))
            .shadow(radius : 15)
            .onHover(perform: onHoverCallback)
    }
}
