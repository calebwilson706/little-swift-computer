//
//  challenge-title.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 12/04/2021.
//

import SwiftUI

extension Text {
    func challengeTitle() -> some View {
        self
            .bold()
            .font(.title3)
            .foregroundColor(Color.white)
            
    }
    
    func challengeCompletionToggleLabel() -> some View {
        self
            .padding(.top,3)
            .foregroundColor(.gray)
            .font(.footnote)
    }
}
