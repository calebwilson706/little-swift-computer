//
//  HeaderWithHelpView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import SwiftUI

struct HeaderWithHelpView: View {
    let title : String
    let helpCallback : () -> Void
    
    var body: some View {
        HStack {
            Text(title)
            HelpButtonView(action: helpCallback)
        }
    }
}

struct HeaderWithHelpView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderWithHelpView(title: "preview", helpCallback: {})
    }
}
