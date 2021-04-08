//
//  ShowHelpHeaderButtonView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 08/04/2021.
//

import SwiftUI

struct ShowHelpHeaderButtonView: View {
    @State var isHoveringOnHeaderButton = false
    let label : String
    let showHelpCallback : (HelpMessages) -> Void
    let helpSelection : HelpMessages
    let isShowing : Bool
    
    var body: some View {
        if isShowing {
            Button(label){
                showHelpCallback(helpSelection)
            }.buttonStyle(ShowHelpFromMainViewHeaderButtonStyle(isHovering: isHoveringOnHeaderButton, onHoverCallback: hoverCallbackForHeaderButtons))
        }
    }
    
    
    private func hoverCallbackForHeaderButtons(isHovering : Bool){
        self.isHoveringOnHeaderButton = isHovering
    }
    
}

