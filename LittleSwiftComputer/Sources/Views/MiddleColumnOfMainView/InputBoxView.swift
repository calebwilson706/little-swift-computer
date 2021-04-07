//
//  InputBoxView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 04/04/2021.
//

import SwiftUI

struct InputBoxView: View {
    let isRunningProgram : Bool
    @Binding var inputString : String
    
    let submitCallback : (Int) -> Void
    let isDisabled : Bool
    
    var parsedInput : Int {
        Int(inputString.filter { $0.isNumber }) ?? 0
    }
    
    @EnvironmentObject var helpController : HelpController
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderWithHelpView(title: "Input:", helpCallback : showHelp, isRunningProgram: isRunningProgram)
            
            Group {
                TextField("", text: $inputString)
                    .background(ComponentMetaData.inputTextField.getColor())
                
                Text("Your input: \(parsedInput)")
                
                Button(action : submit){
                    Text("Submit")
                }.buttonStyle(InputSubmitButtonStyle(disabled: isDisabled))
            }.disabled(isDisabled)
            
        }.padding()
         
    }
    
    private func submit() {
        submitCallback(parsedInput)
    }
    
    private func showHelp() {
        self.helpController.showHelp(selection: .input)
    }
    
}

