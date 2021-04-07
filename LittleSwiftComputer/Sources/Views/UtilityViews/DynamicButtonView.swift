//
//  DynamicButtonView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import SwiftUI

struct DynamicButtonView: View {
    @ObservedObject var dynamicLabel : DynamicButtonLabel
    let action : () -> Void
    let isDisabled : Bool
    let component : ComponentMetaData
    var buttonIconImage : Image {
        Image(systemName: component.getImageStringForComponent() ?? "circlebadge")
            
    }
    
    var body: some View {
        Button(action: action){
            Text("\(dynamicLabel.buttonLabelString) \(buttonIconImage) ")
        }
        .buttonStyle(ControlFlowButtonStyle(
                        methodForHovering: dynamicLabel.changeToCompletedButtonLabelOnHover,
                        disabled: isDisabled,
                        component: component))
        .disabled(isDisabled)
    }
    
}

