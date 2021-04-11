//
//  assembly-view-controller.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 01/04/2021.
//

import Foundation
import SwiftUI

class AssemblyController : ObservableObject {
    @Published var mainCodeBlockString = ""
    @Published var declarationBlockString = ""
    @Published var errorMessageFromAssembly : Error?
    
    func assembleUserInput(soundEffectController : SoundEffectController, shouldPlaySoundEffects : Bool) -> PreparedAndAssembledCode? {
        do {
            withAnimation {
                self.errorMessageFromAssembly = nil
            }
            
            return try AssemblyServices().prepareCodeForRunning(
                mainCodeBlock: self.mainCodeBlockString,
                variableBlock: self.declarationBlockString
            )
            
        } catch {
            withAnimation {
                self.errorMessageFromAssembly = error
            }
            playErrorSound(error: error, shouldPlaySoundEffects: shouldPlaySoundEffects, soundEffectController: soundEffectController)
            return nil
        }
    }
    
    private func playErrorSound(error : Error, shouldPlaySoundEffects : Bool, soundEffectController : SoundEffectController) {
        var soundFilePrefix = ""
        let soundFilePostfix = "-error-sound.mp3"
        
        if let myAssemblyError = error as? AssemblyCodeErrors {
            soundFilePrefix = myAssemblyError.getSoundFilePrefix()
        } else {
            soundFilePrefix = "declaration"
        }
        
        soundEffectController.playSound(
            fileName: soundFilePrefix + soundFilePostfix,
            shouldPlay: shouldPlaySoundEffects
        )
    }
}
