//
//  ErrorView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 05/04/2021.
//

import SwiftUI

struct ErrorView: View {
    
    let errorString : String?
    
    var body: some View {
        if let text = errorString {
            Text(text)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorString: nil)
    }
}
