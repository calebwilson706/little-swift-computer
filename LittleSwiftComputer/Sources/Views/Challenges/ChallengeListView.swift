//
//  ChallengeListView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 12/04/2021.
//

import SwiftUI

struct ChallengeListView: View {
    @ObservedObject var challengeController : ChallengeController
    @ObservedObject var soundEffectController : SoundEffectController
    let width : CGFloat
    let height : CGFloat
    let closeButtonAction : () -> Void
    let shouldPlaySounds : Bool
    
    var body: some View {
        ZStack {
            if challengeController.showingChallenges {
                VStack {
                    header
                    ScrollView {
                        ScrollViewReader { scrollViewProxy in
                            ForEach(challengeController.challenges, id : \.id){
                                ChallengeViewRow(
                                    challenge: $0,
                                    soundEffectController: soundEffectController,
                                    parentViewScrollViewReader: scrollViewProxy,
                                    listHeight: height,
                                    shouldPlaySounds : shouldPlaySounds
                                )
                                Divider()
                            }
                        }
                    }
                    Spacer()
                }.frame(width: width, height: height)
                .background(ComponentMetaData.challengesAlert.getColor().cornerRadius(20))
                .shadow(radius: 20)
                .animation(.easeInOut(duration : 0.3))
            }
        }
    }
    
    var header : some View {
        HStack {
            Text("Challenges")
                .font(.title)
                .bold()
            Spacer()
            Button(action : closeButtonAction){
                Image(systemName: "xmark.circle")
            }.buttonStyle(ShowHelpButtonStyle())
        }.padding()
    }
}
