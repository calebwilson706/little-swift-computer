//
//  OutputView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 04/04/2021.
//

import SwiftUI

struct OutputView: View {
    let isRunningProgram : Bool
    let listOfOutputs : [String]
    
    @EnvironmentObject var helpController : HelpController
    
    init(isRunningProgram : Bool, listOfOutputs : [Int]) {
        self.listOfOutputs = listOfOutputs.map { "\($0)" }
        self.isRunningProgram = isRunningProgram
    }
    
    var body: some View {
        VStack(alignment : .leading) {
            HeaderWithHelpView(title: "Output:", helpCallback : showHelp, isRunningProgram: isRunningProgram)
            ZStack {
                ComponentBackgroundColors.output.getColor()
                ScrollView {
                    ForEach(listOfOutputs.reversed(), id : \.self){
                        Text($0).padding(.horizontal)
                    }.padding(.top)
                }
            }
        }.padding(.all)
         .frame(maxHeight : 300)
    }
    
    func showHelp() {
        helpController.showHelp(selection: .output)
    }
}

struct OutputView_Previews: PreviewProvider {
    static var previews: some View {
        OutputView(isRunningProgram: false, listOfOutputs: [1,2,3,4,5,6])
    }
}
