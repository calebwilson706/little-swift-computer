//
//  HighlightedHelpTextView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 07/04/2021.
//

import SwiftUI

struct HighlightedLeftAlignedHelpTextView: View {
    let text : String
    let highlightColor = ComponentMetaData.highlightedHelpText.getColor()
    
    init(_ text : String){
        self.text = text
    }

    
    var body : some View {
       var isInsideHighlightedBlock = false
       
        return HStack {
            text.reduce(Text(""), { helpTextView, nextChar in
               switch nextChar {
               case "[", "]" :
                   isInsideHighlightedBlock.toggle()
                   return helpTextView
               default :
                   return helpTextView +
                       Text(String(nextChar))
                           .fontWeight(isInsideHighlightedBlock ? .bold : .regular)
                           .foregroundColor(isInsideHighlightedBlock ?  highlightColor : .white)

               }
            })
            Spacer()
        }
    }
}

struct HighlightedHelpTextView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightedLeftAlignedHelpTextView("this is a [test]")
    }
}
