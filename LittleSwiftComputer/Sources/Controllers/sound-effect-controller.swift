//
//  sound-effect-controller.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 11/04/2021.
//

import Foundation
import AVFoundation

class SoundEffectController : ObservableObject {
    @Published var myAudioPlayer : AVAudioPlayer? = nil

    func playSound(fileName : String, shouldPlay : Bool) {
        guard shouldPlay else {
            return
        }
        
        myAudioPlayer?.stop()
        
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil) else {
            return
        }
        
        let urlOfSound = URL(fileURLWithPath: filePath)
        
        if let mySoundEffectInFile = try? AVAudioPlayer(contentsOf: urlOfSound) {
            myAudioPlayer = mySoundEffectInFile
            myAudioPlayer?.play()
        } 
    }

}
