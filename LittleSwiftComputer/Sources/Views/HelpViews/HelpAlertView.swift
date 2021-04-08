//
//  HelpAlertView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import SwiftUI

struct HelpAlertView: View {
    @EnvironmentObject var helpController : HelpController
    let widthAndHeight : CGFloat
    
    var body: some View {
        VStack {
            if let selectedHelpSection = helpController.helpSelection {
                VStack(alignment : .leading) {
                    HStack {
                        Text(selectedHelpSection.getHeaderForAlert())
                            .underline()
                            .font(.title2)
                            .foregroundColor(Color.white)
                        Spacer()
                        dismissButton
                    }
                    ScrollView {
                        ScrollViewReader { scroller in
                            ForEach(selectedHelpSection.getHelpTextLines(), id : \.offset){ index, textLine in
                                HighlightedLeftAlignedHelpTextView(textLine)
                            }.onChange(of: selectedHelpSection){ _ in
                                withAnimation {
                                    scroller.scrollTo(0)
                                }
                            }
                            ChangeHelpButtonView(selectedHelp: selectedHelpSection, callback: changeHelp)
                                .padding(.bottom)
                        }
                    }
                }.padding()
            }
        }.background(ComponentMetaData.helpAlert.getColor().cornerRadius(20))
        .frame(maxWidth : widthAndHeight, maxHeight: widthAndHeight)
        .shadow(radius: 20)
        .animation(.easeInOut(duration : 0.3))
    }
    
    var dismissButton : some View {
        Button(action: hideAlert){
            Image(systemName: "xmark.circle")
        }.buttonStyle(ShowHelpButtonStyle())
    }
    
    func hideAlert() {
        self.helpController.helpSelection = nil
    }
    
    func changeHelp(to selection: HelpMessages ) {
        self.helpController.showHelp(selection: selection)
    }
}

struct HelpAlertView_Previews: PreviewProvider {
    static var previews: some View {
        HelpAlertView(widthAndHeight: 350)
            .environmentObject(HelpController())

    }
}
