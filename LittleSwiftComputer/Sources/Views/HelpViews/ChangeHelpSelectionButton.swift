//
//  ChangeHelpSelectionButton.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 08/04/2021.
//

import SwiftUI

struct ChangeHelpButtonView : View {
    let selectedHelp : HelpMessages
    let callback : (HelpMessages) -> Void
    let defaultColor = ComponentMetaData.changeHelpButton.getColor()
    
    @State var isHoveringOnButton : Bool = false
    
    var body : some View {
        VStack {
            if let correspondingHelp = selectedHelp.partner() {
                Button(correspondingHelp.labelOfButtonWhichChangesToThis){
                    callback(correspondingHelp.helpBeingChangedTo)
                }.buttonStyle(ChangeHelpButtonStyle(isHoveringOnButton: isHoveringOnButton, onHoverCallback: updateHoverStatus))
            }
        }
    }
    
    func updateHoverStatus(isHovering : Bool){
        self.isHoveringOnButton = isHovering
    }
}
