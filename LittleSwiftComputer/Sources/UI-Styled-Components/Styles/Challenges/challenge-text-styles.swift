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
            .padding(.trailing)
            .frame(minHeight : 50)
            .foregroundColor(isShowingTip ? .white : .gray)
            .onTapGesture(perform: toggleTipStatus)
    }
    
    func exampleSolutionTextStyle() -> some View {
        self
            .padding(.top)
            .foregroundColor(Color.white)
            .fixedSize(horizontal: false, vertical: true)
        
    }
    
}
