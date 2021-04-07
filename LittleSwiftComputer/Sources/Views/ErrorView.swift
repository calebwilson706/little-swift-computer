//
//  ErrorView.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 05/04/2021.
//

import SwiftUI

struct ErrorView: View {
    
    let error : Error?
    
    var backgroundColor : Color {
        let component : ComponentMetaData = (error?.localizedDescription == ExecutionErrors.requiresInput.localizedDescription ? .inputRequiredMessage : .errorMessage)
        return component.getColor()
    }
    
    var body: some View {
        if let text = error?.localizedDescription {
            Text(text)
                .font(.title3)
                .foregroundColor(Color.white)
                .padding()
                .background(backgroundColor.cornerRadius(10))
                .animation(Animation.linear(duration: 0.5).delay(0.2))
                
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: nil)
    }
}
