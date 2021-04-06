//
//  AccumulatorView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 05/04/2021.
//

import SwiftUI

struct AccumulatorView: View {
    let accumulator: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderWithHelpView(title: "Accumulator:", helpCallback : {})
            ZStack {
                ComponentBackgroundColors.accumulator.getColor()
                Text("\(accumulator)")
            }.frame(maxHeight: 50)
        }.padding(.all)
    }
}

