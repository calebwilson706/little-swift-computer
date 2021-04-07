//
//  AccumulatorView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 05/04/2021.
//

import SwiftUI

struct AccumulatorView: View {
    let isRunningProgram : Bool
    let accumulator: Int
    @EnvironmentObject var helpController : HelpController
        
    var body: some View {
        VStack(alignment: .leading) {
            HeaderWithHelpView(title: "Accumulator:", helpCallback : showHelp, isRunningProgram: isRunningProgram)
            ZStack {
                ComponentMetaData.accumulator.getColor()
                Text("\(accumulator)")
            }.frame(maxHeight: 50)
        }.padding(.all)
    }
    
    private func showHelp() {
        helpController.showHelp(selection: .accumulator)
    }
}

