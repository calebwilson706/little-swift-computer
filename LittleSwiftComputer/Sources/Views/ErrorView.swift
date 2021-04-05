//
//  ErrorView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 05/04/2021.
//

import SwiftUI

struct ErrorView: View {
    
    let error : Error?
    
    var body: some View {
        if let text = error?.localizedDescription {
            Text(text)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: nil)
    }
}
