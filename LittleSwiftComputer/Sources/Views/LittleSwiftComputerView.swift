//
//  ContentView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 30/03/2021.
//

import SwiftUI

struct LittleSwiftComputerView: View {
    @ObservedObject var assemblyViewController = AssemblyController()
    @ObservedObject var executor = ExecutionController()
    
    @State var runButtonLabelString = ""
    @State var cancelButtonLabelString = ""
    @State var inputString = ""
    
    let runAndCancelButtonAnimation = Animation.easeInOut(duration: 0.5)
    let purpleColourForAccumulator = Color(red: 147.convertToRGBValue(), green: 99.convertToRGBValue(), blue: 207.convertToRGBValue())
    
    var body: some View {
        VStack {
            HStack {
                Text(assemblyViewController.errorMessageFromAssembly ?? "")
                VStack {
                    codeAssemblyView
                    runAndCancelButtons
                }.padding(.all)
                VStack {
                    accumulatorView
                    OutputView(listOfOutputs : executor.outputs)
                        .frame(maxHeight : 300)
                    InputBoxView(inputString: $inputString,
                                 submitCallback: { input in
                                    executor.resumeAfterInput(inputNumber: input)
                                    self.inputString = ""
                                 },
                                 backgroundColor: purpleColourForAccumulator,
                                 isDisabled: !executor.requiresInput
                    )
                    Spacer()
                }
                GridOfRegistersView(registerItems: executor.registers.values.sorted { $0.indexForDisplay < $1.indexForDisplay })
                Text(self.executor.executionError ?? "")
            }.padding()
        }
    }
    
    var codeAssemblyView : some View {
        VStack(alignment : .leading) {
            Text("Write Code Below:")
            TextEditor(text: self.$assemblyViewController.mainCodeBlockString)
            Text("Declare Variables Below:")
            TextEditor(text: self.$assemblyViewController.declarationBlockString)
        }
    }
    
    var accumulatorView : some View {
        VStack(alignment: .leading) {
            Text("Accumulator:")
            ZStack {
                purpleColourForAccumulator
                Text("\(self.executor.accumulator)")
            }.frame(maxWidth : 100, maxHeight: 50)
        }.padding(.all)
    }
    
    var runAndCancelButtons : some View {
        HStack {
            runButton
            cancelButton
        }
    }
    
    var runButton : some View {
        Button(action : {
            if let assembledCode = assemblyViewController.assembleUserInput() {
                executor.execute(assembledCode)
            }
        }){
            Text("\(runButtonLabelString) \(Image(systemName: "play.fill"))")
        }.buttonStyle(RunButtonStyle(methodForHovering: appendStringToStartOfRunButton, disabled: executor.isRunning || executor.requiresInput))
        .disabled(executor.isRunning)
    }
    
    var cancelButton : some View {
        Button(action: {
            executor.resetProgram()
        }){
            Text("\(cancelButtonLabelString) \(Image(systemName: "square.fill"))")
        }.buttonStyle(CancelButtonStyle(methodForHovering: appendStringToStartOfCancelButton, disabled: !executor.isRunning))
        .disabled(!executor.isRunning)
    }
    
    private func appendStringToStartOfRunButton(isHoveringOverButton : Bool) {
        animateChangeOfButtonLabel(isHoveringOverButton: isHoveringOverButton) { status in
            self.runButtonLabelString = status ? "Execute Code" : ""
        }
    }
    
    private func appendStringToStartOfCancelButton(isHoveringOverButton : Bool) {
        animateChangeOfButtonLabel(isHoveringOverButton: isHoveringOverButton) { status in
            self.cancelButtonLabelString = status ? "Stop Execution" : ""
        }
    }
    
    private func animateChangeOfButtonLabel(isHoveringOverButton : Bool, changeMethod : (Bool) -> Void) {
        withAnimation(runAndCancelButtonAnimation) {
            changeMethod(isHoveringOverButton)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LittleSwiftComputerView()
    }
}
