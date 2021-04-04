//
//  GridOfRegistersView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 04/04/2021.
//

import SwiftUI

struct GridOfRegistersView: View {
    let registerItems : [RegisterData]
    
    let layout = [
        GridItem(.flexible(minimum: 20.0, maximum: 50.0), spacing: 5),
        GridItem(.flexible(minimum: 20.0, maximum: 50.0), spacing: 5),
        GridItem(.flexible(minimum: 20.0, maximum: 50.0), spacing: 5),
        GridItem(.flexible(minimum: 20.0, maximum: 50.0), spacing: 5)
    ]
    
    var body: some View {
        VStack(alignment : .leading) {
            Text("Registers: ")
            LazyVGrid(columns: layout, spacing : 12.5) {
                ForEach(registerItems, id : \.id) { register in
                    VStack {
                        VStack {
                            Text("\(register.indexForDisplay)")
                                .padding(.top, 3)
                            Text("\(register.value)")
                                .padding(.bottom, 3)
                        }.padding(.horizontal)
                    }.border(Color.gray)
                }
            }
            Spacer()
        }.padding()
    }
}

