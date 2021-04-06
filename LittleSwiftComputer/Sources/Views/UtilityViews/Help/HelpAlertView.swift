//
//  HelpAlertView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import SwiftUI

struct HelpAlertView: View {
    @EnvironmentObject var helpController : HelpController
    
    var body: some View {
        VStack {
            if helpController.showingHelpMessage {
                ScrollView {
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: hideAlert){
                                Image(systemName: "xmark.circle")
                            }.buttonStyle(HelpButtonStyle())
                        }
                        Text(helpController.helpSelection.getHeaderForAlert())
                            .font(.title2)
                        Spacer()
                        Text(helpController.helpSelection.rawValue)
                        Spacer()
                    }.padding()
                }
            }
        }.background(ComponentBackgroundColors.helpAlert.getColor().cornerRadius(20))
         .frame(maxWidth : 300, maxHeight: 300)
         .shadow(radius: 20)
        .animation(.easeInOut(duration : 0.3))
    }
    
    func hideAlert() {
        self.helpController.showingHelpMessage = false
        self.helpController.helpSelection = .none
    }
}

struct HelpAlertView_Previews: PreviewProvider {
    static var previews: some View {
        HelpAlertView()
            .environmentObject(HelpController())

    }
}
