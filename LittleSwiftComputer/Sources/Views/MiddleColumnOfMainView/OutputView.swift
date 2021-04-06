//
//  OutputView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 04/04/2021.
//

import SwiftUI

struct OutputView: View {
    let listOfOutputs : [String]
    
    init(listOfOutputs : [Int]) {
        self.listOfOutputs = listOfOutputs.map { "\($0)" }
    }
    
    var body: some View {
        VStack(alignment : .leading) {
            Text("Output:")
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
}

struct OutputView_Previews: PreviewProvider {
    static var previews: some View {
        OutputView(listOfOutputs: [1,2,3,4,5,6])
    }
}
