//
//  ExtraSettingsView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import SwiftUI

struct ExtraSettingsView: View {
    @ObservedObject var optionsController : OptionsController
    @EnvironmentObject var helpController : HelpController
    var isRunningProgram : Bool
    
    var body: some View {
        VStack(alignment : .leading) {
            HeaderWithHelpView(title: "Extra Settings:", helpCallback : showHelp, isRunningProgram: isRunningProgram)
            speedPickerView
            playSoundEffectsToggle
        }.padding(.all)
         .disabled(isRunningProgram)
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
    
    var playSoundEffectsToggle : some View {
        HStack {
            Text("Play Sound Effects: ")
                .optionsHeader()
            Spacer()
            Toggle("", isOn : $optionsController.shouldPlaySoundEffects)
                .labelsHidden()
                .onChange(of: optionsController.shouldPlaySoundEffects, perform: keepHelpShouldPlayStatusUpToDate)
        }
    }
    
    func showHelp() {
        self.helpController.showHelp(selection: .extraSettings)
    }
    
    func keepHelpShouldPlayStatusUpToDate(status : Bool){
        self.helpController.shouldPlaySounds = status
    }
}

