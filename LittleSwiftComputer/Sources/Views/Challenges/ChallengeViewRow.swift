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
    @State var isShowingTip = false
    
    let listHeight : CGFloat
    
    var body: some View {
        VStack {
            header
            descriptionAndShowSolutionButton
            tipTextView
            solutionText
        }.padding(.all)
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
                Text(challenge.exampleSolution)
                        .foregroundColor(Color.white)
                Spacer()
            }
        }.padding(.top)
    }
    
    var descriptionAndShowSolutionButton : some View {
        HStack {
            Text(challenge.description)
            Spacer()
            Button(action: toggleSolutionShowing){
                toggleShowingSolutionLabel
            }.buttonStyle(ShowSolutionButtonStyle())
        }.frame(minHeight : listHeight/10)
    }
    
    var tipTextView : some View {
        HStack(spacing: 0) {
            if let tip = challenge.tip {
                Text("Tip: ")
                Text(isShowingTip ? tip : tip.scrambledText())
                    .tipTextStyle(onTap: toggleTipShowing, isShowingTip: isShowingTip)
                Spacer()
            }
        }
    }
    
    func toggleSolutionShowing() {
        withAnimation {
            self.isShowingSolution.toggle()
        }
    }
    
    func toggleTipShowing() {
        withAnimation {
            self.isShowingTip.toggle()
        }
    }
    
}

struct ChallengeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeViewRow(challenge: assemblyCodeInitialChallenges.first!, listHeight: 500)
    }
}
