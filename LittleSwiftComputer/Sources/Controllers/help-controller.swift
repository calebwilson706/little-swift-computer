//
//  help-controller.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import Foundation
import SwiftUI

class HelpController : ObservableObject {
    @Published var showingHelpMessage = false
    @Published var helpSelection : HelpMessages = .none
    
    func showHelp(selection : HelpMessages) {
        self.showingHelpMessage = true
        self.helpSelection = selection
    }
}
