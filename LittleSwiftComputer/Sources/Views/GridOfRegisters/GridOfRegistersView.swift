//
//  GridOfRegistersView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 04/04/2021.
//

import SwiftUI

struct GridOfRegistersView: View {
    let isRunningProgram : Bool
    let registerItems : [RegisterData]

    let layout = [
        GridItem(.flexible(), spacing: 5.0),
        GridItem(.flexible(), spacing: 5.0),
        GridItem(.flexible(), spacing: 5.0),
        GridItem(.flexible(), spacing: 5.0),
        GridItem(.flexible(), spacing: 5.0)
    ]
    
    
    
    var remainingEmptyRegisters : [RegisterData] {
        (registerItems.count ..< 100).map { RegisterData(indexForDisplay: $0, value: 0) }
    }
    
    @EnvironmentObject var helpController : HelpController
    
    var body: some View {
        VStack(alignment : .leading) {
            HeaderWithHelpView(title: "Registers: ", helpCallback : showHelp, isRunningProgram: isRunningProgram)
            ScrollView {
                LazyVGrid(columns: layout, spacing : 12.5) {
                    ForEach(registerItems, id : \.id, content : RegisterView.init).overlay(Color.gray.opacity(0.1))
                    ForEach(remainingEmptyRegisters, id : \.id, content : RegisterView.init).overlay(Color.black.opacity(0.6))
                }
                Spacer()
            }.padding(.vertical)
        }.padding()
    }
    
    func showHelp() {
        self.helpController.showHelp(selection: .registers)
    }
}

