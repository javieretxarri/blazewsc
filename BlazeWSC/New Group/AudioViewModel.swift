//
//  AudioViewModel.swift
//
//
//  Created by Javier Garcia on 16/2/24.
//

import Foundation
import AVKit
import SwiftUI

public class AudioViewModel: ObservableObject {
    private var timer: Timer? = nil
    @Published var isAudioPlaying = false
    @Published var isAudioPrepared = false
    @Published var audioPlayer: AVPlayer?
    @Published var totalTime: Double?
    @Published var currentTime: Double?
    @Published var audio: AudioDataModel
    var isFinished: Bool = false
    @Published var selectedTime: Double = 0 {
        didSet {
            seekTo(seconds: selectedTime)
        }
    }
    @Published var isMovingSlider: Bool = false {
        didSet {
            if isMovingSlider {
                timer?.invalidate()
                audioPlayer?.pause()
                isAudioPlaying = false
            } else {
                setTimer()
                audioPlayer?.play()
                isAudioPlaying = true
            }
        }
    }
    init(
        audio: AudioDataModel
    ) {
        self.audio = audio
        isAudioPrepared = prepareToPlay(audioUrl: audio.url)
        if isAudioPrepared {
            setTimer()
        }
    }
    func statWithDelay() {
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            if isAudioPrepared {
                setTimer()
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
    public func prepareToPlay(audioUrl: String) -> Bool {
        // New asset
        guard let url = URL(string: audioUrl) else {
            return false
        }
        let asset = AVAsset(url: url)
        guard asset.isPlayable == true else {
            return false
        }
        let playerItem = AVPlayerItem(asset: asset)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidPlayToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        self.audioPlayer = AVPlayer(playerItem: playerItem)
        return true
    }
    
    func playAudio() {
        if isAudioPrepared {
            if isAudioPlaying {
                self.audioPlayer?.pause()
                isAudioPlaying = false
            } else {
                if isFinished {
                    isFinished = false
                    seekTo(seconds: 0)
                }
                setTimer()
                self.audioPlayer?.play()
                isAudioPlaying = true
            }
        } else {
            if self.prepareToPlay(audioUrl: audio.url) {
                isAudioPrepared = true
                playAudio()
            } else {
                isAudioPrepared = false
                isAudioPlaying = false
            }
        }
    }
    
    func seekTo(seconds: Double) {
        if isAudioPrepared {
            let time = CMTime(seconds: seconds, preferredTimescale: 60000)
            audioPlayer?.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
        }
    }
    
    public func setTimer() {
        self.totalTime = self.audioPlayer?.currentItem?.duration.seconds
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            // Update times
            self.currentTime = self.audioPlayer?.currentItem?.currentTime().seconds
        })
    }
    
    @objc func handleTap(_ tap: UITapGestureRecognizer) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let touchLocation = tap.location(in: windowScene.windows.first)
        selectedTime = min(max(0, touchLocation.x), UIScreen.main.bounds.width)
    }
    
    @objc func playerItemDidPlayToEndTime() {
        isFinished = true
        isAudioPlaying = false
    }
}
extension Double {
    var formattedTime: String {
        guard self > 0 else { return "00:00" }
        let totalSeconds = Int(self)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
