//
//  ContentView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 30/03/2021.
//

import SwiftUI

struct LittleSwiftComputerView: View {
    @ObservedObject var assemblerController = AssemblyController()
    @ObservedObject var executionController = ExecutionController()
    @ObservedObject var optionsController = ExecutionOptionsController()
    
    @State var runButtonLabelString = ""
    @State var cancelButtonLabelString = ""
    @State var inputString = ""
    
    let runAndCancelButtonAnimation = Animation.easeInOut(duration: 0.5)
    
    var body: some View {
        VStack {
            Text("Little Swift Computer")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
            HStack {
                Spacer()
                
                ErrorView(error: executionController.executionError)
                ErrorView(error: assemblerController.errorMessageFromAssembly)
                
                VStack {
                    codeAssemblyView
                    runAndCancelButtons
                }.padding(.all)
                
                VStack {
                    AccumulatorView(accumulator: self.executionController.accumulator)
                    OutputView(listOfOutputs : executionController.outputs)
                    InputBoxView(inputString: $inputString,
                                 submitCallback: inputSubmitCallback,
                                 isDisabled: !executionController.requiresInput)
                    extraSettingsView
                }.frame(maxWidth : 200)
                
                GridOfRegistersView(registerItems: executionController.registers.values.sorted { $0.indexForDisplay < $1.indexForDisplay })
            }
        }.padding()
    }
    
    var extraSettingsView : some View {
        VStack(alignment : .leading) {
            Text("Extra Settings:")
            speedPickerView
        }.padding(.all)
    }
    
    var speedPickerView : some View {
        VStack(alignment : .leading) {
            Text("Execution Speed: ")
                .optionsHeader()
            Picker("", selection: self.$optionsController.selectedSpeedOption) {
                ForEach(ExecutionSpeeds.allCases, id : \.self) {
                    Text($0.getDescription())
                        .tag($0)
                }
            }
            .labelsHidden()
        }
    }
    
    var codeAssemblyView : some View {
        VStack(alignment : .leading) {
            Text("Write Code Below:")
            TextEditor(text: self.$assemblerController.mainCodeBlockString)
                .codeEditor()
            Text("Declare Variables Below:")
            TextEditor(text: self.$assemblerController.declarationBlockString)
                .codeEditor()
        }
    }
    
    var runAndCancelButtons : some View {
        HStack {
            runButton
            cancelButton
        }
    }
    
    var runButton : some View {
        Button(action : executeNewUserInput){
            Text("\(runButtonLabelString) \(Image(systemName: "play.fill"))")
        }
        .buttonStyle(RunButtonStyle(methodForHovering: appendStringToStartOfRunButton, disabled: isRunButtonDisabled))
        .disabled(isRunButtonDisabled)
    }
    
    var cancelButton : some View {
        Button(action: executionController.resetProgram){
            Text("\(cancelButtonLabelString) \(Image(systemName: "square.fill"))")
        }
        .buttonStyle(CancelButtonStyle(methodForHovering: appendStringToStartOfCancelButton, disabled: isCancelButtonDisabled))
        .disabled(isCancelButtonDisabled)
    }
    
    private var isRunButtonDisabled : Bool {
        executionController.isRunning || executionController.requiresInput
    }
    
    private var isCancelButtonDisabled : Bool {
        !isRunButtonDisabled
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
        withAnimation(runAndCancelButtonAnimation.delay(isHoveringOverButton ? 0 : 0.1)) {
            changeMethod(isHoveringOverButton)
        }
    }
    
    private func inputSubmitCallback(inputNumber : Int) {
        executionController.resumeAfterInput(inputNumber: inputNumber, speedSelection: self.optionsController.selectedSpeedOption)
        self.inputString = ""
    }
    
    private func executeNewUserInput() {
        if let assembledCode = assemblerController.assembleUserInput() {
            executionController.execute(assembledCode: assembledCode, speedSelection: self.optionsController.selectedSpeedOption)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LittleSwiftComputerView()
    }
}
