//
//  ContentView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 30/03/2021.
//

import SwiftUI

struct LittleSwiftComputerView: View {
    @ObservedObject var assemblyViewController = AssemblyViewController()
    @ObservedObject var executor = Executor()
    
    var body: some View {
        VStack {
            HStack {
                Text(assemblyViewController.errorMessageFromAssembly ?? "")
                Text("\(self.executor.accumulator)")
                VStack {
                    Text("Write Code Below:")
                    TextEditor(text: $assemblyViewController.mainCodeBlockString)
                    Text("Declare Variables Below:")
                    TextEditor(text: $assemblyViewController.declarationBlockString)
                    Button(action : {
                        if let assembledCode = assemblyViewController.assembleUserInput() {
                            executor.execute(assembledCode)
                        }
                    }){
                        Text("Run Code")
                    }
                    Button(action: {
                        executor.resetProgram()
                    }){
                        Text("Cancel Running")
                    }
                }.padding(.all)
                Text(executor.executionError ?? "")
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LittleSwiftComputerView()
    }
}
