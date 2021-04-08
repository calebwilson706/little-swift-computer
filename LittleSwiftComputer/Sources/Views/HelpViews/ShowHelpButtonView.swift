//
//  HelpButtonView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import SwiftUI

struct ShowHelpButtonView: View {
    let action : () -> Void
    
    var body: some View {
        Button(action: action){
            Image(systemName: "questionmark.circle")
        }.buttonStyle(ShowHelpButtonStyle())
    }
}

struct ShowHelpButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShowHelpButtonView(action: {})
    }
}
