//
//  register-grid-item-styles.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 07/04/2021.
//

import SwiftUI

extension View {
    func roundedCornersForGridAndMiddleStack() -> some View {
        return self
            .cornerRadius(10)
    }
    
    func gridItemInUseStyle() -> some View {
        return self
            .overlay(Color.gray.opacity(0.1).roundedCornersForGridAndMiddleStack())
    }
    
    func gridItemOutOfUseStyle(colorScheme : ColorScheme) -> some View {
        return self
            .overlay((colorScheme == .dark ? Color.black : Color.secondary).opacity(0.6).roundedCornersForGridAndMiddleStack())
    }
    
}
