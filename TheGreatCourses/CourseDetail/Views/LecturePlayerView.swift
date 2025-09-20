//
//  LecturePlayerView.swift
//  TheGreatCourses
//
//  Created by KUMAR ABHINAV on 20/09/25.
//

import SwiftUI
import AVKit

struct LecturePlayerView: View {
    let url: URL
    @State private var player: AVPlayer?
    
    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                player = AVPlayer(url: url)
                player?.play()
            }
            .onDisappear {
                player?.pause()
                player = nil
            }
            .navigationTitle("Now Playing")
            .navigationBarTitleDisplayMode(.inline)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LecturePlayerView(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!)
}
