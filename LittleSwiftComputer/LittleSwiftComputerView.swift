//
//  ContentView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 30/03/2021.
//

import SwiftUI

struct LittleSwiftComputerView: View {
    @ObservedObject var assemblyViewController = AssemblyViewController()
    
    var body: some View {
        VStack {
            HStack {
                Text(assemblyViewController.errorMessageFromAssembly ?? "")
                VStack {
                    Text("Write Code Below:")
                    TextEditor(text: $assemblyViewController.mainCodeBlockString)
                    Text("Declare Variables Below:")
                    TextEditor(text: $assemblyViewController.declarationBlockString)
                    Button(action : {
                        let _ = assemblyViewController.assembleUserInput()
                    }){
                        Text("Run Code")
                    }
                }.padding(.all)
                Spacer()
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LittleSwiftComputerView()
    }
}
