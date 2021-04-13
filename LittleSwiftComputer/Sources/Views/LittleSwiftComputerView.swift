//
//  ContentView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 30/03/2021.
//

import SwiftUI

struct LittleSwiftComputerView: View {
    @StateObject var assemblerController = AssemblyController()
    @StateObject var executionController = ExecutionController()
    @StateObject var optionsController = OptionsController()
    @StateObject var helpController = HelpController()
    @StateObject var dynamicLabels = DynamicButtonLabelsController()
    @StateObject var soundEffectController = SoundEffectController()
    @StateObject var challengeController = ChallengeController()
    
    @State private var inputString = ""
    
    var body: some View {
        VStack(alignment: .center) {
            GeometryReader { geometry in
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
                                ExtraSettingsView(optionsController: optionsController, isRunningProgram: executionController.isRunning)
                            }.frame(maxWidth : 200)
                                
                            GridOfRegistersView(isRunningProgram: executionController.isRunning, registerItems: executionController.registersForDisplaying)
                                .frame(maxWidth : geometry.size.width*0.4)
                                .frame(minWidth : 300)
                        }
                        footer
                    }.padding()
                    .blur(radius: popoverShowing ? 20 : 0)
                    .disabled(popoverShowing)
                    
                    HelpAlertView(widthAndHeight: geometry.size.width/4)
                    ChallengeListView(
                        challengeController: challengeController,
                        width: geometry.size.width/2,
                        height: geometry.size.height/2,
                        closeButtonAction: toggleChallengesShowing
                    )
                }
            }
        }.environmentObject(helpController)
         .onAppear(perform: assignSoundEffectControllerToOtherControllers)
    }
    
    var header : some View {
        HStack(alignment: .center) {
            ShowHelpHeaderButtonView(
                label: "LSC Instruction Set",
                showHelpCallback: helpController.showHelp,
                helpSelection: .instructionSetHelp,
                isShowing: !executionController.isRunning
            )
            Spacer()
            Text("Little Swift Computer")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            ShowHelpHeaderButtonView(
                label: "What is assembly code?",
                showHelpCallback: helpController.showHelp,
                helpSelection: .assemblyCode,
                isShowing: !executionController.isRunning
            )
        }.padding(.top, 10)
        .padding(.horizontal, 20)
    }
    
    var footer : some View {
        HStack {
            Text("Created by Caleb Wilson.")
                .font(.footnote)
            Spacer()
            ShowHelpButtonView(action: showChallengesHelp)
            Button(action : toggleChallengesShowing) {
                Text("Show Challenges")
            }.buttonStyle(ShowChallengesButtonStyle())
        }.padding(.leading, 20)
        .padding(.bottom, 10)
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
            action: showResume ? resumeExecution : executeNewUserInput,
            isDisabled: !showResume && !executionController.canRunProgram,
            component: showResume ? .resumeButton : .runButton
        )
    }
    
    var pauseButton : some View {
        DynamicButtonView(
            dynamicLabel: dynamicLabels.pauseButtonLabel,
            action: executionController.pause,
            isDisabled: !executionController.canPauseProgram,
            component: .pauseButton
        )
    }
    
    var cancelButton : some View {
        DynamicButtonView(
            dynamicLabel: dynamicLabels.cancelButtonLabel,
            action: stopExecution,
            isDisabled: !executionController.canStopProgram,
            component: .cancelButton
        )
    }
    
    private func inputSubmitCallback(inputNumber : Int) {
        executionController.resumeAfterInput(inputNumber: inputNumber, optionsController: optionsController)
        self.inputString = ""
    }
    
    private func executeNewUserInput() {
        if let assembledCode = assemblerController.assembleUserInput(
            soundEffectController: self.soundEffectController,
            shouldPlaySoundEffects: self.optionsController.shouldPlaySoundEffects
        ) {
            executionController.execute(assembledCode: assembledCode, optionsController: optionsController)
        } else {
            executionController.resetProgram()
        }
    }
    
    private func resumeExecution() {
        executionController.resume(optionsController: optionsController)
        soundEffectController.playSound(fileName: "resume-execution-sound.mp3", shouldPlay: optionsController.shouldPlaySoundEffects)
        withAnimation {
            dynamicLabels.resumeButtonLabel.buttonLabelString = ""
        }
    }
    
    private func stopExecution() {
        soundEffectController.playSound(fileName: "stop-execution-sound.mp3", shouldPlay: optionsController.shouldPlaySoundEffects)
        executionController.resetProgram()
    }
    
    private func showCodeEditorHelp() {
        helpController.showHelp(selection: .assemblyCodeEditor)
    }
    
    private func showDeclarationEditorHelp() {
        helpController.showHelp(selection: .variableDeclarationEditor)
    }
    
    private func showChallengesHelp() {
        helpController.showHelp(selection: .challenges)
    }
    
    private func assignSoundEffectControllerToOtherControllers() {
        helpController.soundEffectController = soundEffectController
        executionController.soundEffectController = soundEffectController
    }
    
    private var popoverShowing : Bool {
        helpController.isShowingHelp || challengeController.showingChallenges
    }
    
    private func toggleChallengesShowing() {
        withAnimation {
            self.challengeController.showingChallenges.toggle()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LittleSwiftComputerView()
    }
}
