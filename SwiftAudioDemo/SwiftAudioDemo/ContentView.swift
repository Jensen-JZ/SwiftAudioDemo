//
//  ContentView.swift
//  SwiftAudioDemo
//
//  Created by Jensen Jon on 2021/11/16.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            AudioPlayer().navigationTitle("Radio Player")
        }
    }
}

struct AudioPlayer: View {
    @State var current = 0
    let radioLists = RadioChannels().getRadio()
    let screen = UIScreen.main.bounds.width - 30
    let rc = RadioController()
    var body: some View {
        VStack(spacing: 20) {
            Image(uiImage: UIImage(named: radioLists[current].image)!)
                .resizable()
                .frame(width: radioLists[current].image != "" ? screen: nil, height: 250)
                .cornerRadius(15)
            Text(radioLists[current].title).font(.title).padding(.top)
            
            HStack(spacing: UIScreen.main.bounds.width / 5 - 30) {
                Button(action: {
                    if current > 0 {
                        current -= 1
                    } else {
                        current = radioLists.count - 1
                    }
                    rc.changeRadios(current: current, radioLists: radioLists)
                }) {
                    Image(systemName: "backward.fill").font(.largeTitle)
                }
                Button(action: {
                    rc.playRadio()
                }) {
                    Image(systemName: "arrow.clockwise.circle.fill").font(.largeTitle)
                }
                Button(action: {
                    if radioLists.count - 1 != current {
                        current += 1
                    } else {
                        current = 0
                    }
                    rc.changeRadios(current: current, radioLists: radioLists)
                }) {
                    Image(systemName: "forward.fill").font(.largeTitle)
                }
            }.padding(.top, 25)
                .foregroundColor(Color.red)
        }.padding()
        .onAppear{
            rc.onAppear(current: current, radioLists: radioLists)
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemPlaybackStalled, object: nil, queue: .main) { (Notification) in
                print("Playback stalled...")
                rc.playRadio()
            }
        }
    }
    
}


class RadioController: NSObject, AVSpeechSynthesizerDelegate {
    var player = AVPlayer()
    var utterance = AVSpeechUtterance()
    var current = 0
    var voice = AVSpeechSynthesizer()
    var radioLists: [Channels] = []
    let synthesizer = AVSpeechSynthesizer()
    
    
    func onAppear(current: Int, radioLists: [Channels]) {
        self.current = current
        self.radioLists = radioLists
        utterance = AVSpeechUtterance(string: radioLists[current].voice)
        utterance.voice = AVSpeechSynthesisVoice.init(language: "zh_CN")
        utterance.rate = 0.6
        synthesizer.speak(utterance)
        synthesizer.delegate = self
    }
    
    func changeRadios(current: Int, radioLists: [Channels]) {
        self.current = current
        self.radioLists = radioLists
        player.pause()
        synthesizer.stopSpeaking(at: .immediate)
        utterance = AVSpeechUtterance(string: radioLists[current].voice)
        utterance.voice = AVSpeechSynthesisVoice.init(language: "zh_CN")
        utterance.rate = 0.6
        synthesizer.speak(utterance)
        synthesizer.delegate = self
    }
    
    func playRadio() {
        let item = AVPlayerItem(url: self.radioLists[current].url)
        self.player.replaceCurrentItem(with: item)
        self.player.play()
        print("Playing audio...")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        playRadio()
    }
}
