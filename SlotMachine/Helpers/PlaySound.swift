//
//  PlaySound.swift
//  SlotMachine
//
//  Created by Orlando Moraes Martins on 12/03/23.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL (fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR: Couldn't find and play the sound file!")
        }
    }
}
