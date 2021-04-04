//
//  OutputView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 04/04/2021.
//

import SwiftUI

struct OutputView: View {
    let listOfOutputs : [Int]
    
    var body: some View {
        VStack(alignment : .leading) {
            Text("Output:")
            ZStack {
                Color.gray
                ScrollView {
                    ForEach(listOfOutputs.reversed(), id : \.self){ output in
                        Text("\(output)")
                    }.padding(.top)
                }
            }.frame(maxWidth : 100)
        }.padding(.all)
    }
}

struct OutputView_Previews: PreviewProvider {
    static var previews: some View {
        OutputView(listOfOutputs: [1,2,3,4,5,6])
    }
}
