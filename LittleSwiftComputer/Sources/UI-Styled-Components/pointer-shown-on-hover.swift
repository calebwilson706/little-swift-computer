//
//  pointer-shown-on-hover.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 08/04/2021.
//

import SwiftUI

extension View {
    func showPointingHandOnHover() -> some View {
        return self
            .onHover { hovering in
                hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
            }
    }
}
