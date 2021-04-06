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
    
    @ObservedObject var runButtonLabel = DynamicButtonLabel(completedString: "Execute Code")
    @ObservedObject var cancelButtonLabel = DynamicButtonLabel(completedString: "Stop Execution")
    @ObservedObject var resumeButtonLabel = DynamicButtonLabel(completedString: "Resume Execution")
    @ObservedObject var pauseButtonLabel = DynamicButtonLabel(completedString: "Pause Execution")
    
    @State var inputString = ""
    
    
    
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
                    controlExecutionButtons
                }.padding(.all)
                
                VStack {
                    AccumulatorView(accumulator: self.executionController.accumulator)
                    OutputView(listOfOutputs : executionController.outputs)
                    InputBoxView(inputString: $inputString,
                                 submitCallback: inputSubmitCallback,
                                 isDisabled: !executionController.requiresInput)
                    ExtraSettingsView().environmentObject(optionsController)
                }.frame(maxWidth : 200)
                
                GridOfRegistersView(registerItems: executionController.registers.values.sorted { $0.indexForDisplay < $1.indexForDisplay })
            }
        }.padding()
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
    
    var controlExecutionButtons : some View {
        HStack {
            runButton
            pauseButton
            cancelButton
        }
    }
    
    var runButton : some View {
        let showResume = executionController.isPaused
        return DynamicButtonView(
            dynamicLabel: showResume ? resumeButtonLabel : runButtonLabel,
            imageName: "play.fill",
            action: showResume ? resumeExecution : executeNewUserInput,
            isDisabled: !showResume && isRunButtonDisabled,
            component: showResume ? .pauseButton : .runButton
        )
    }
    
    var pauseButton : some View {
        DynamicButtonView(
            dynamicLabel: pauseButtonLabel,
            imageName: "pause.fill",
            action: executionController.pause,
            isDisabled: !isRunButtonDisabled || executionController.isPaused,
            component: .pauseButton
        )
    }
    
    var cancelButton : some View {
        DynamicButtonView(
            dynamicLabel: cancelButtonLabel,
            imageName: "square.fill",
            action: executionController.resetProgram,
            isDisabled: isCancelButtonDisabled,
            component: .cancelButton
        )
    }
    
    private var isRunButtonDisabled : Bool {
        (executionController.isRunning || executionController.requiresInput || executionController.isPaused)
    }
    
    private var isCancelButtonDisabled : Bool {
        !isRunButtonDisabled
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
    
    private func resumeExecution() {
        executionController.resume(speedSelection: optionsController.selectedSpeedOption)
        self.resumeButtonLabel.buttonLabelString = ""
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LittleSwiftComputerView()
    }
}
