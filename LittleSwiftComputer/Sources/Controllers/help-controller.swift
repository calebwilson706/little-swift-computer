//
//  help-controller.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import Foundation
import SwiftUI
import AVFoundation

class HelpController : ObservableObject {
    @Published var helpSelection : HelpMessages? = nil
    
    var soundEffectController : SoundEffectController? = nil
    var shouldPlaySounds : Bool = true
    
    var isShowingHelp : Bool {
        helpSelection != nil
    }
    
    func showHelp(selection : HelpMessages) {
        soundEffectController?.playSound(fileName: "open-help-sound.mp3", shouldPlay: shouldPlaySounds)
        self.helpSelection = selection
    }
    
    func assignSoundEffectController(controller : SoundEffectController){
        self.soundEffectController = controller
    }
}
