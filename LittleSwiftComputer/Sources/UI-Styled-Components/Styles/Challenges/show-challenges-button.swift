//
//  show-challenges-button.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 12/04/2021.
//

import SwiftUI

struct ShowChallengesButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.gray)
            .background(Color.clear)
            .showPointingHandOnHover()
    }
}
