//
//  help-controller.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import Foundation
import SwiftUI

class HelpController : ObservableObject {
    @Published var helpSelection : HelpMessages? = nil
    var isShowingHelp : Bool {
        helpSelection != nil
    }
    func showHelp(selection : HelpMessages) {
        self.helpSelection = selection
    }
}
