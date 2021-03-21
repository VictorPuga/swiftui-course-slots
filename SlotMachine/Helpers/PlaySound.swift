//
//  PlaySound.swift
//  SlotMachine
//
//  Created by Víctor Manuel Puga Ruiz on 21/03/21.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      audioPlayer?.play()
    } catch {
      print("ERROR: Couldn't find and play the sound file")
    }
  }
}
