//
//  RegisterView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 05/04/2021.
//

import SwiftUI

struct RegisterView: View {
    
    let register : RegisterData
    let verticalMargin : CGFloat = 3
    
    var body: some View {
        VStack {
            Text("\(register.indexForDisplay)")
                .foregroundColor(Color.gray)
                .padding(.top, verticalMargin)
            Text("\(register.value)")
                .padding(.bottom, verticalMargin)
        }.padding(.horizontal)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray)
        )
    }
}
