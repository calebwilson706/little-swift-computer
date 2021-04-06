//
//  ExtraSettingsView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import SwiftUI

struct ExtraSettingsView: View {
    @EnvironmentObject var optionsController : ExecutionOptionsController
    
    var body: some View {
        VStack(alignment : .leading) {
            HeaderWithHelpView(title: "Extra Settings:", helpCallback : {})
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
    
}

