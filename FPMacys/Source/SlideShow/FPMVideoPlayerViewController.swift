//
//  FPMVideoPlayerViewController.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/8/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

private enum VideoPlayerError: ErrorType {
    case InvalidResource(name: String, type: String)
}

class FPMVideoPlayerViewController: AVPlayerViewController {
    
    private var firstAppear = true
    private let videoFileName = "video"
    private let videoFileFormat = "mp4"
    private var playerLayer:AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.autoresizingMask = [.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleLeftMargin, .FlexibleRightMargin]
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "videoPlayerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: player?.currentItem)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        showsPlaybackControls = false
        view.frame = (navigationController?.view.bounds)!
        if firstAppear {
            do {
                try playVideo()
                firstAppear = false
            } catch VideoPlayerError.InvalidResource(let name, let type) {
                debugPrint("Could not find resource \(name).\(type)")
            } catch {
                debugPrint("Oops, something wrong when playing video.m4v")
            }
        }
    }
    
    //Loop the video again if reaches end.
    func videoPlayerItemDidReachEnd(notification: NSNotification) {
        let playerItem = notification.object
        playerItem?.seekToTime(kCMTimeZero)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resetPlayerLayerToFullScreen()
    }
    
    private func resetPlayerLayerToFullScreen() {
        let bounds = view.layer.bounds;
        if let videoPlayerLayer = playerLayer {
            videoPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            videoPlayerLayer.bounds = bounds;
            videoPlayerLayer.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
        }
    }
    
    private func playVideo() throws {
        if let videoPlayer = player {
            videoPlayer.play()
        } else if let pathForResource = NSBundle.mainBundle().pathForResource(videoFileName, ofType: videoFileFormat) {
            let url = NSURL(fileURLWithPath: pathForResource)
            player = AVPlayer(URL: url)
            playerLayer = AVPlayerLayer(player: player)
            resetPlayerLayerToFullScreen()
            view.layer.addSublayer(playerLayer!)
            player?.play()
            player?.actionAtItemEnd = .None
        } else {
            throw VideoPlayerError.InvalidResource(name: videoFileName, type: videoFileFormat)
        }
    }
    
    //Handle user touch when the video is playing.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        player?.pause()
        firstAppear = true
        NSNotificationCenter.defaultCenter().postNotificationName(kLaunchHomeScreenOrPreviousScreen, object: nil)
    }

}
