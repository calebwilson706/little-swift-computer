//
//  HelpButtonView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import SwiftUI

struct HelpButtonView: View {
    let action : () -> Void
    
    var body: some View {
        Button(action: action){
            Image(systemName: "questionmark.circle")
        }.buttonStyle(HelpButtonStyle())
    }
}

struct HelpButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color.clear)
            .imageScale(.medium)
            .onHover { hovering in
                hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
            }
            .foregroundColor(Color.gray)
    }
}

struct HelpButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HelpButtonView(action: {})
    }
}
