//
//  DynamicButtonView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import SwiftUI

struct DynamicButtonView: View {
    @ObservedObject var dynamicLabel : DynamicButtonLabel
    let imageName : String
    let action : () -> Void
    let isDisabled : Bool
    let component : ComponentBackgroundColors
    
    var body: some View {
        Button(action: action){
            Text("\(dynamicLabel.buttonLabelString) \(Image(systemName : imageName)) ")
        }
        .buttonStyle(ControlFlowButtonStyle(
                        methodForHovering: dynamicLabel.changeToCompletedButtonLabelOnHover,
                        disabled: isDisabled,
                        component: component))
        .disabled(isDisabled)
    }
}

