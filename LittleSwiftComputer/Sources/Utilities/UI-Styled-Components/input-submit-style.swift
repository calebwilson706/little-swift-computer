//
//  input-submit-style.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import SwiftUI

struct InputSubmitButtonStyle : ButtonStyle {
    let disabled : Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(BaseRunPauseCancelButtonStyle(onHoverCallback: { _ in }, component: .runButton, disabled: disabled))
    }
}
