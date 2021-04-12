//
//  ChallengeViewRow.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 12/04/2021.
//

import SwiftUI

struct ChallengeViewRow: View {
    @ObservedObject var challenge : ChallengeContainer
    @State var isShowingSolution = false
   
    var body: some View {
        VStack {
            header
            descriptionAndShowSolutionButton
            solutionText
        }.padding(.all)
    }
    
    func toggleSolutionShowing() {
        withAnimation {
            self.isShowingSolution.toggle()
        }
    }
    
    var header : some View {
        HStack {
            Text(challenge.challengeTitle)
                .challengeTitle()
            Spacer()
            Text("completed:")
                .challengeCompletionToggleLabel()
            Toggle("", isOn: $challenge.hasBeenCompleted)
                
        }
    }
    
    var toggleShowingSolutionLabel : some View {
        Text("\(isShowingSolution ? "Hide" : "Show") Solution")
    }
    
    var solutionText : some View {
        HStack {
            if isShowingSolution {
                ScrollView {
                    Text(challenge.exampleSolution)
                }
                Spacer()
            }
        }
    }
    
    var descriptionAndShowSolutionButton : some View {
        HStack {
            Text(challenge.description)
            Spacer()
            Button(action: toggleSolutionShowing){
                toggleShowingSolutionLabel
            }.buttonStyle(ShowSolutionButtonStyle())
        }
    }
}

struct ChallengeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeViewRow(challenge: assemblyCodeInitialChallenges.first!)
    }
}
