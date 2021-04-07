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
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment : .leading) {
            HeaderWithHelpView(title: "Registers: ", helpCallback : showHelp, isRunningProgram: isRunningProgram)
            ScrollView {
                LazyVGrid(columns: layout, spacing : 12.5) {
                    ForEach(registerItems, id : \.id, content : RegisterView.init)
                        .gridItemInUseStyle()
                    ForEach(remainingEmptyRegisters, id : \.id, content : RegisterView.init)
                        .gridItemOutOfUseStyle(colorScheme: colorScheme)
                }.padding(.top, 5)
                Spacer()
            }.padding(.vertical)
        }.padding()
    }
    
    func showHelp() {
        self.helpController.showHelp(selection: .registers)
    }
    
}

