//
//  assembly-view-controller.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 01/04/2021.
//

import Foundation
import SwiftUI

class AssemblyController : ObservableObject {
    @Published var mainCodeBlockString = ""
    @Published var declarationBlockString = ""
    @Published var errorMessageFromAssembly : Error?
    
    func assembleUserInput() -> PreparedAndAssembledCode? {
        do {
            withAnimation {
                self.errorMessageFromAssembly = nil
            }
            
            return try AssemblyServices().prepareCodeForRunning(
                mainCodeBlock: self.mainCodeBlockString,
                variableBlock: self.declarationBlockString
            )
        } catch {
            withAnimation {
                self.errorMessageFromAssembly = error
            }
            return nil
        }
    }
}
