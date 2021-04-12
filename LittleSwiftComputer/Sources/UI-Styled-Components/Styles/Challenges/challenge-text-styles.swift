//
//  challenge-title.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 12/04/2021.
//

import SwiftUI

public extension Text {
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
    
    func tipTextStyle(onTap toggleTipStatus : @escaping () -> Void, isShowingTip : Bool) -> some View {
        self
            .foregroundColor(isShowingTip ? .white : .gray)
            .onTapGesture(perform: toggleTipStatus)
    }
    
}
