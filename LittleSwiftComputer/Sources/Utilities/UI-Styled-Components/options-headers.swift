//
//  options-headers.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import SwiftUI

extension Text {
    func optionsHeader() -> some View {
        return self
            .padding(.top, 3)
            .foregroundColor(Color.gray)
            .font(.footnote)
    }
}
