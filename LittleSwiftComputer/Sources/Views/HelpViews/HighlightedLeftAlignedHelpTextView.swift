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
       var isInsideSearchTerm = false
       
        return HStack {
            text.reduce(Text(""), { helpTextView, nextChar in
               switch nextChar {
               case "[":
                   isInsideSearchTerm = true
                   return helpTextView
               case "]":
                   isInsideSearchTerm = false
                   return helpTextView
               default :
                   return helpTextView +
                       Text(String(nextChar))
                           .fontWeight(isInsideSearchTerm ? .bold : .regular)
                           .foregroundColor(isInsideSearchTerm ?  highlightColor : .white)

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
