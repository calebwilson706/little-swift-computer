//
//  ExtraSettingsView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import SwiftUI

struct ExtraSettingsView: View {
    @EnvironmentObject var optionsController : ExecutionOptionsController
    @EnvironmentObject var helpController : HelpController
    var isRunningProgram : Bool
    
    var body: some View {
        VStack(alignment : .leading) {
            HeaderWithHelpView(title: "Extra Settings:", helpCallback : showHelp, isRunningProgram: isRunningProgram)
            speedPickerView
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
    
    func showHelp() {
        self.helpController.showHelp(selection: .extraSettings)
    }
    
}

