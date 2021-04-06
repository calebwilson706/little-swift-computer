//
//  InputBoxView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 04/04/2021.
//

import SwiftUI

struct InputBoxView: View {
    
    @Binding var inputString : String
    
    let submitCallback : (Int) -> Void
    let isDisabled : Bool
    
    var parsedInput : Int {
        Int(inputString.filter { $0.isNumber }) ?? 0
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Input: ")
            TextField("", text: $inputString)
                .background(ComponentBackgroundColors.inputTextField.getColor())
            Text("Your input: \(parsedInput)")
            Button(action : {
                submitCallback(parsedInput)
            }){
                Text("Submit")
            }.buttonStyle(InputSubmitButtonStyle(disabled: isDisabled))
            
        }.padding()
         .disabled(isDisabled)
    }
}

