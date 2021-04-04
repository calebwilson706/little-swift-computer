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
    let backgroundColor : Color
    let isDisabled : Bool
    
    var parsedInput : Int {
        Int(inputString.filter { $0.isNumber }) ?? 0
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Input: ")
            TextField("", text: $inputString)
                .background(backgroundColor)
                .disabled(isDisabled)
            Text("Your input: \(parsedInput)")
            Button(action : {
                submitCallback(parsedInput)
            }){
                Text("Submit")
            }.buttonStyle(RunButtonStyle(methodForHovering: { _ in }, disabled: isDisabled))
        }.frame(maxWidth: 100)
         .padding()
    }
}

//struct InputBoxView_Previews: PreviewProvider {
//    static var previews: some View {
//        InputBoxView(inputString: "", submitCallback: ())
//    }
//}
