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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "sign up video", ofType: "mp4")!) 
        
        let player = AVPlayer(url: url)
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
