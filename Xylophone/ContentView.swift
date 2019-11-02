//
//  ContentView.swift
//  test
//
//  Created by Stéphane Lux on 30.10.2019.
//  Copyright © 2019 LUXio IT-Solutions. All rights reserved.
//

import SwiftUI
import AVFoundation

var player: AVAudioPlayer!

struct ContentView: View {
  
  var body: some View {
    let xylophoneBars:[XylophoneBar] = [
        ("C", Color(.systemRed)),
        ("D", Color(.systemOrange)),
        ("E", Color(.systemYellow)),
        ("F", Color(.systemGreen)),
        ("G", Color(.systemIndigo)),
        ("A", Color(.systemBlue)),
        ("B", Color(.systemPurple))
        ].map {XylophoneBar(color: $0.1, key: $0.0)}
      
       let horizontalPadding:CGFloat = 5

      return VStack {
        ForEach(xylophoneBars.indices) { i in
          XylophoneBarView(xylophoneBar: xylophoneBars[i], horizontalPadding: (CGFloat(i+1)  * horizontalPadding))
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct XylophoneBar : Identifiable {
  var id = UUID()
  var color: Color
  var key: String
}

struct XylophoneBarView: View {
  
  var xylophoneBar: XylophoneBar
  var horizontalPadding: CGFloat
  
  @State var opacity = 1.0
  
  var body: some View {
    Button(action: {
      self.playSound(soundName: self.xylophoneBar.key)
      self.opacity = 0.5
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        self.opacity = 1.0
      }      
    }) {
      VStack(alignment: .center) {
        Spacer()
        HStack {
          Spacer()
          Text(xylophoneBar.key)
            .font(.system(size: 40))
            .foregroundColor(.white)
          Spacer()
        }
        Spacer()
      }
    }
    .background(xylophoneBar.color)
    .padding(.horizontal, horizontalPadding)
    .padding(.vertical, 5 )
    .opacity(opacity)
  }
    
  func playSound(soundName: String) {
    let url = Bundle.main.url(forResource: self.xylophoneBar.key, withExtension: "wav")
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
  }
}
