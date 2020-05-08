//
//  UIVideoPlayer.swift
//  UWShare
//
//  Created by Jason Chen on 2020-05-06.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import Foundation
import SwiftUI
import AVKit

class UIVideoPlayer: UIView {
    var playerLayer = AVPlayerLayer()
    var videoLooper: AVPlayerLooper
    
    override init(frame: CGRect) { // add parameter for different urls
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "sign up", ofType: "mp4")!)

        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer(playerItem: item)
        videoLooper = AVPlayerLooper(player: player, templateItem: item)
        super.init(frame: frame)
        
        //let player = AVPlayer(url: url)
        player.isMuted = true
        player.play()
        
        playerLayer.player = player
        playerLayer.videoGravity = AVLayerVideoGravity(rawValue: AVLayerVideoGravity.resizeAspectFill.rawValue)
        layer.addSublayer(playerLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct PlayerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVideoPlayer {
        return UIVideoPlayer()
    }
    
    func updateUIView(_ uiView: UIVideoPlayer, context: Context) {
        
    }
    
}
