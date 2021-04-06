//
//  dynamic-button-label.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import Foundation
import SwiftUI

class DynamicButtonLabel : ObservableObject {
    @Published var buttonLabelString = ""
    let completedString : String
    
    init(completedString: String) {
        self.completedString = completedString
    }
    
    func changeToCompletedButtonLabelOnHover(isHovering : Bool) {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            self.buttonLabelString = isHovering ? completedString : ""
        }
    }
}
