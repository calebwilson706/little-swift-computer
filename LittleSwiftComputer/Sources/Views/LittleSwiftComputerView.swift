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
    @ObservedObject var helpController = HelpController()
    @ObservedObject var dynamicLabels = DynamicButtonLabelsController()
    @State var inputString = ""
    
    
    
    var body: some View {
        ZStack {
            VStack {
                header
                HStack {
                    Spacer()
                    
                    ErrorView(error: executionController.executionError)
                    ErrorView(error: assemblerController.errorMessageFromAssembly)
                    
                    VStack {
                        codeAssemblyView
                        controlExecutionButtons
                    }.padding(.all)
                    
                    VStack {
                        AccumulatorView(isRunningProgram: executionController.isRunning, accumulator: self.executionController.accumulator)
                        OutputView(isRunningProgram: executionController.isRunning, listOfOutputs : executionController.outputs)
                        InputBoxView(isRunningProgram: executionController.isRunning,
                                     inputString: $inputString,
                                     submitCallback: inputSubmitCallback,
                                     isDisabled: !executionController.requiresInput)
                        ExtraSettingsView(isRunningProgram: executionController.isRunning).environmentObject(optionsController)
                    }.frame(maxWidth : 200)
                        
                    GridOfRegistersView(isRunningProgram: executionController.isRunning, registerItems: executionController.registersForDisplaying)
                }
            }.padding()
            .blur(radius: helpController.showingHelpMessage ? 20 : 0)
            .disabled(helpController.showingHelpMessage)
            
            HelpAlertView()
            
        }.environmentObject(helpController)
        
    }
    
    var header : some View {
        Text("Little Swift Computer")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 10)
    }
    
    var codeAssemblyView : some View {
        VStack(alignment : .leading) {
            HeaderWithHelpView(title: "Write Code Below:", helpCallback: showCodeEditorHelp, isRunningProgram: executionController.isRunning)
            TextEditor(text: self.$assemblerController.mainCodeBlockString)
                .codeEditor()
            HeaderWithHelpView(title: "Declare Variables Below:", helpCallback: showDeclarationEditorHelp, isRunningProgram: executionController.isRunning)
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
            dynamicLabel: showResume ? dynamicLabels.resumeButtonLabel : dynamicLabels.runButtonLabel,
            imageName: "play.fill",
            action: showResume ? resumeExecution : executeNewUserInput,
            isDisabled: !showResume && !executionController.canRunProgram,
            component: showResume ? .pauseButton : .runButton
        )
    }
    
    var pauseButton : some View {
        DynamicButtonView(
            dynamicLabel: dynamicLabels.pauseButtonLabel,
            imageName: "pause.fill",
            action: executionController.pause,
            isDisabled: !executionController.canPauseProgram,
            component: .pauseButton
        )
    }
    
    var cancelButton : some View {
        DynamicButtonView(
            dynamicLabel: dynamicLabels.cancelButtonLabel,
            imageName: "square.fill",
            action: executionController.resetProgram,
            isDisabled: !executionController.canStopProgram,
            component: .cancelButton
        )
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
        
        withAnimation {
            dynamicLabels.resumeButtonLabel.buttonLabelString = ""
        }
    }
    
    private func showCodeEditorHelp() {
        helpController.showHelp(selection: .assemblyCodeEditor)
    }
    
    private func showDeclarationEditorHelp() {
        helpController.showHelp(selection: .variableDeclarationEditor)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LittleSwiftComputerView()
    }
}
