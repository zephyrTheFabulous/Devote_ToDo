//
//  PlaySound.swift
//  DevoteCoreData
//
//  Created by Anthony on 12/11/24.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
      audioPlayer?.play()
    } catch {
      print("no file found")
    }
  }
}

