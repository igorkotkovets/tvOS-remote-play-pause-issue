//
//  ViewController.swift
//  PlayPauseBug
//
//  Created by igork on 8/10/17.
//  Copyright © 2017 Igor Kotkovets. All rights reserved.
//

import UIKit
import AVKit

class PlayerView: UIControl {
    override static var layerClass: AnyClass { return AVPlayerLayer.self }
    var playerLayer: AVPlayerLayer { return layer as! AVPlayerLayer }
    var player: AVPlayer? {
        get { return playerLayer.player }
        set { playerLayer.player = newValue }
    }
}

class ViewController: UIViewController {
    let videoUrl = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8")!
    weak var player: AVPlayer?
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var outputTextView: UITextView!
    var viewControllerIsHidden = false

    @IBAction func onPlayVideo(_ sender: UIButton) {
        log(string: "func onPlayVideo(_ sender: UIButton)")
        openVideoInFullscreen()
    }

    func log(string: String) {
        let line = "\n" + Date().description + ":    " + string
        outputTextView.text = outputTextView.text.appending(line)
        scrollToBottom(textView: outputTextView)
    }


    func scrollToBottom(textView: UITextView) {
        let length = textView.text.lengthOfBytes(using: .utf8)
        if length > 0 {
            textView.scrollRangeToVisible(NSMakeRange(length-1, 1))
        }
    }

    func openVideoInFullscreen() {
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        player = AVPlayer(url: videoUrl)
        player?.play()
        playerView.player = player
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewControllerIsHidden = false
        log(string: "func viewDidAppear(_ animated: Bool)")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewControllerIsHidden = true
        log(string: "viewDidDisappear(_ animated: Bool)")
    }

    open override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        super.pressesBegan(presses, with: event)

        if presses.first(where: { $0.type == .playPause }) != nil {
            log(string: "func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?)")
            if viewControllerIsHidden {
                return
            }

            if player?.rate == 0 {
                player?.play()
                log(string: "put player to play")
            } else {
                player?.pause()
                log(string: "put player on pause")
            }
        }
    }
}

