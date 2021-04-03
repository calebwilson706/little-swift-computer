//
//  ContentView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 30/03/2021.
//

import SwiftUI

struct LittleSwiftComputerView: View {
    @ObservedObject var assemblyViewController = AssemblyController()
    @ObservedObject var executor = ExecutionController()
    
    @State var runButtonLabelString = ""
    @State var cancelButtonLabelString = ""
    
    var body: some View {
        VStack {
            HStack {
                Text(assemblyViewController.errorMessageFromAssembly ?? "")
                Text("\(self.executor.accumulator)")
                VStack {
                    codeAssemblyView
                    runAndCancelButtons
                }.padding(.all)
                Text(executor.executionError ?? "")
            }.padding()
        }
    }
    
    var codeAssemblyView : some View {
        VStack {
            Text("Write Code Below:")
            TextEditor(text: $assemblyViewController.mainCodeBlockString)
            Text("Declare Variables Below:")
            TextEditor(text: $assemblyViewController.declarationBlockString)
        }
    }
    
    var runAndCancelButtons : some View {
        HStack {
            Button(action : {
                if let assembledCode = assemblyViewController.assembleUserInput() {
                    executor.execute(assembledCode)
                }
            }){
                Text("\(runButtonLabelString) \(Image(systemName: "play.fill"))")
            }.buttonStyle(RunButtonStyle(methodForHovering: appendStringToStartOfRunButton))
            Button(action: {
                executor.resetProgram()
            }){
                Text("\(cancelButtonLabelString) \(Image(systemName: "square.fill"))")
            }.buttonStyle(CancelButtonStyle(methodForHovering: appendStringToStartOfCancelButton))
        }
    }
    
    func appendStringToStartOfRunButton(status : Bool) {
        withAnimation {
            self.runButtonLabelString = status ? "Execute Code" : ""
        }
    }
    func appendStringToStartOfCancelButton(status : Bool) {
        withAnimation {
            self.cancelButtonLabelString = status ? "Stop Execution" : ""
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LittleSwiftComputerView()
    }
}
