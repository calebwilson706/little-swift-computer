//
//  assembly-view-controller.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 01/04/2021.
//

import Foundation

class AssemblyController : ObservableObject {
    @Published var mainCodeBlockString = ""
    @Published var declarationBlockString = ""
    @Published var errorMessageFromAssembly : String? = nil
    
    func assembleUserInput() -> PreparedAndAssembledCode? {
        do {
            self.errorMessageFromAssembly = nil
            return try AssemblyServices().prepareCodeForRunning(
                mainCodeBlock: self.mainCodeBlockString,
                variableBlock: self.declarationBlockString
            )
        } catch {
            self.errorMessageFromAssembly = (mainCodeBlockString == "") ?
                "Please write some code to run." : error.localizedDescription
            return nil
        }
    }
}
