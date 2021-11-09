//
//  ContentView.swift
//  NetDemo
//
//  Created by Jensen on 2021/11/5.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @ObservedObject var netdemo: NetDemo
    @State private var activityText: String = ""
    let url = URL(string: "https://cdn.jsdelivr.net/gh/Jen-Jon/CDN_Bank/newschannels.json")!
    
    var body: some View {
//        VStack {
//            Text(activityText)
//            start
//            video
//        }
        NavigationView {
            MusicPlayer().navigationBarTitle("Audio Player")
        }
    }
    
    
    var start: some View {
        Button("start") {
            getData(url: url)
//            assetTest()
        }
    }
    
    var video: some View {
        VideoPlayer(player: AVPlayer(url: URL(string: "http://ngcdn001.cnr.cn/live/zgzs/index.m3u8")!))
            
    }
    
    func getData(url: URL) {
        netdemo.decodeData(url: url) { channelList in
            activityText = channelList[Int(arc4random_uniform(UInt32(channelList.count)))]
        }
    }
    
//    func assetTest() {
//        let url = Bundle.main.path(forResource: "music", ofType: "mp3")
//        let asset = AVAsset(url: URL(fileURLWithPath: url!))
//
//        for i in asset.commonMetadata {
//            print(i.commonKey?.rawValue)
//            print(i.value)
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let netdemo = NetDemo()
        return ContentView(netdemo: netdemo)
    }
}

struct MusicPlayer: View {
    
    @State var data: Data = .init(count: 0)  // Stored the audio metadata
    @State var title = ""  // Stored the audio title
    @State var player: AVAudioPlayer!  // The audio player
    @State var playing = false  // A flag that determines whether audio is playing
    @State var width: CGFloat = 0  // Stored the length of the playback process bar
    @State var songs = ["keyword", "hot"]  // Audio list
    @State var current = 0  // The order of the audio in list
    @State var finish = false  // A flag that determines whether the audio is finished
    @State var del = AVdelegate()
    
    var body: some View {
        
        VStack(spacing: 20) {
            Image(uiImage: self.data.count == 0 ? UIImage(named: "itunes")! :  UIImage(data: self.data)!)
                .resizable()
                .frame(width: self.data.count == 0 ? 250 : nil, height: 250)  // The size of the audio cover in View
                .cornerRadius(15)
            
            Text(self.title).font(.title).padding(.top)  // Show the audio title in View
            
            ZStack(alignment: .leading) {
                Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)  // Background of the playback process bar
                Capsule().fill(Color.red).frame(width: self.width, height: 8)  // Playback process bar
                    .gesture(DragGesture()  // Drag the playback process bar
                                .onChanged({ (value) in
                        let x = value.location.x
                        
                        self.width = x  // The length of process bar changes with drag gesture
                    
                    }).onEnded({ (value) in
                        let x = value.location.x
                        
                        let screen = UIScreen.main.bounds.width - 30
                        
                        let percent = x / screen
                        
                        // After the drag gesture ends, play the audio in corresponding position
                        self.player.currentTime = Double(percent) * self.player.duration
                        
                    }))
            }.padding(.top)
            
            HStack(spacing: UIScreen.main.bounds.width / 5 - 30) {
                Button(action: {  // Switch to the previous audio
                    if self.current > 0 {
                        self.current -= 1
                        self.changeSongs()
                    }
                }) {
                    Image(systemName: "backward.fill").font(.title)
                }
                
                Button(action: {  // Back for 15s
                    self.player.currentTime -= 15
                }) {
                    Image(systemName: "gobackward.15").font(.title)
                }
                
                Button(action: {  // Play or pause
                    if self.player.isPlaying {
                        self.player.pause()
                        self.playing = false
                    } else {
                        
                        if self.finish {
                            self.player.currentTime = 0
                            self.width = 0
                            self.finish = false
                        }
                        self.player.play()
                        self.playing = true
                    }
                }) {
                    Image(systemName: self.playing && !self.finish ? "pause.fill" : "play.fill").font(.title)
                }
                
                Button(action: {  // Forward for 15s
                    let increase = self.player.currentTime + 15
                    if increase < self.player.duration {
                        self.player.currentTime = increase
                    }
                }) {
                    Image(systemName: "goforward.15").font(.title)
                }
                
                Button(action: {  // Switch to the next audio
                    if self.songs.count - 1 != self.current {
                        self.current += 1
                        self.changeSongs()
                    }
                    
                }) {
                    Image(systemName: "forward.fill").font(.title)
                }
                
            }.padding(.top, 25)
                .foregroundColor(.black)
            
        }.padding()
        .onAppear {
            
            let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
            
            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))

            self.player.delegate = self.del

            self.player.prepareToPlay()
            
            self.getData()
            
            // Creates a timer and schedules it on the current run loop in the default mode
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                if self.player.isPlaying {
                    let screen = UIScreen.main.bounds.width - 30
                    let value = self.player.currentTime / self.player.duration
                    self.width = screen * CGFloat(value)  // Update the width of process bar
                }
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Finish"), object: nil, queue: .main) { (_) in
                self.finish = true
            }
        }
        
        
    }
    
    func getData() {  // Get the audio data
        let asset = AVAsset(url: self.player.url!)
        
        for i in asset.commonMetadata {
            if i.commonKey?.rawValue == "artwork" {
                let data = i.value as! Data
                self.data = data
            }
            if i.commonKey?.rawValue == "title" {
                let title = i.value as! String
                self.title = title
            }
        }
    }
    
    func changeSongs() {  // Switch audios
        let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
        
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        
        self.player.delegate = self.del
        
        self.data = .init(count: 0)
        self.title = ""
        
        self.player.prepareToPlay()
        self.getData()
        
        self.playing = true
        
        self.finish = false
         
        self.width = 0
        
        self.player.play()
    }
}

class AVdelegate: NSObject, AVAudioPlayerDelegate {
    // Tells the delegate when the audio finishes playing.
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
    }
}
