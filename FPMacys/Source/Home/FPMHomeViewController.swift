//
//  FPMHomeViewController.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/5/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class FPMHomeViewController: UIViewController {

    @IBOutlet weak var browseAllDressesButton: UIButton!
    @IBOutlet weak var scanDressButton: UIButton!
    @IBOutlet weak var bookAnAppointmentButton: UIButton!
    @IBOutlet weak var findYourDressButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var bookAppointment: FPMAppointmentCustomView?
    private var adminCustomview: FPMAdminLoginCustomView?
    private var adminListOfOrdersCustomView: FPMAdminListOfOrdersCustomView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set attributed titles for the buttons
        bookAnAppointmentButton.titleLabel?.numberOfLines = 0
        setAttributedTitleForButton(bookAnAppointmentButton, normalText: "VIP \nappointment", italicText: "Book a ")
        setAttributedTitleForButton(browseAllDressesButton, normalText: "all dresses", italicText: "Browse ")
        setAttributedTitleForButton(scanDressButton, normalText: "a dress", italicText: "Scan ")
        setAttributedTitleForButton(aboutButton, normalText: "F&P", italicText: "About ")
        setAttributedTitleForButton(findYourDressButton, normalText: "the dress for you", italicText: "Find ")
        findYourDressButton.layer.borderWidth = 1.0
        findYourDressButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showHomeScreen", name: kNavigateToHomeScreenNotification, object: nil)
    }
    
    func showAdminListOfOrdersScreen() {
        if adminListOfOrdersCustomView == nil {
            adminListOfOrdersCustomView = FPMAdminListOfOrdersCustomView.instanceFromNib() as? FPMAdminListOfOrdersCustomView
            adminListOfOrdersCustomView?.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
            view.addSubview(adminListOfOrdersCustomView!)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "closeAdminListOfOrdersCustomView", name: kAdminScreenCloseButtonTappedNotification, object: nil)
            adminCustomview?.removeFromSuperview()
            adminCustomview = nil
            player?.pause()
        }
    }
    
    func closeAdminListOfOrdersCustomView() {
        adminListOfOrdersCustomView?.removeFromSuperview()
        adminListOfOrdersCustomView = nil
        player?.play()
    }
    
    func adminLoginClosed() {
        adminCustomview?.removeFromSuperview()
        adminCustomview = nil
        NSUserDefaults.standardUserDefaults().setObject("YES", forKey: kAdminLoginDidCloseKey)
    }
    
    private func showAdminLogin() {
        if let didClose = NSUserDefaults.standardUserDefaults().objectForKey(kAdminLoginDidCloseKey) as? String {
            if didClose == "YES" {
                //do nothing.
            }else{
                if adminCustomview == nil {
                    //Launch Admin Custom View
                    adminCustomview = FPMAdminLoginCustomView.instanceFromNib() as? FPMAdminLoginCustomView
                    adminCustomview!.frame = CGRectMake(150, 110, 510, 400)
                    view.addSubview(adminCustomview!)
                    NSNotificationCenter.defaultCenter().addObserver(self, selector: "adminLoginClosed", name: kAdminLoginCloseButtonTappedNotification, object: nil)
                    NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAdminListOfOrdersScreen", name: kLoginButtonTappedNotification, object: nil)
                    NSNotificationCenter.defaultCenter().addObserver(self, selector: "showLoginAlert:", name: kLoginFailedNotification, object: nil)
                }
                NSUserDefaults.standardUserDefaults().setObject("NO", forKey: kAdminLoginDidCloseKey)
            }
        }
    }
    
    func showLoginAlert(notification: NSNotification) {
        let alertController = UIAlertController(title: notification.object as? String, message:"Please complete all required fields to continue." , preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showHomeScreen() {
        navigationController?.popToViewController(self, animated: true)
    }
    
    @IBAction func bookAnAppointmentButtonTapped(sender: AnyObject) {
        if bookAppointment == nil {
            bookAppointment = FPMAppointmentCustomView.instanceFromNib() as? FPMAppointmentCustomView
            bookAppointment?.frame = CGRectMake(130, 115, 510, 750)
            view.addSubview(bookAppointment!)
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appointmentCloseButtonTapped", name: kCloseButtonTappedOnPDPNotification, object: nil)
    }
    
    func appointmentCloseButtonTapped() {
        bookAppointment?.removeFromSuperview()
        bookAppointment = nil
    }
    
    private func setAttributedTitleForButton(button: UIButton, normalText: String, italicText: String) {
        let italicAttributedText = NSMutableAttributedString(string: italicText, attributes: (button == findYourDressButton) ? [NSFontAttributeName: FPMFont.FreightDispBookItalic.withExplicitSize(30),NSForegroundColorAttributeName: UIColor.whiteColor()]:[NSFontAttributeName: FPMFont.FreightDispBookItalic.withExplicitSize(30),NSForegroundColorAttributeName: UIColor.blackColor()])
        let normalAttributedText = NSAttributedString(string: normalText, attributes: (button == findYourDressButton) ? [NSFontAttributeName: FPMFont.FreightBigLight.withExplicitSize(30),NSForegroundColorAttributeName: UIColor.whiteColor()]: [NSFontAttributeName: FPMFont.FreightDispProLightRegular.withExplicitSize(30),NSForegroundColorAttributeName: UIColor.blackColor()])
        italicAttributedText.appendAttributedString(normalAttributedText)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.grayColor().CGColor
        button.setAttributedTitle(italicAttributedText, forState: .Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBarHidden = true
        
        showAdminLogin()
        playVideoForQuiz()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSNotificationCenter.defaultCenter().postNotificationName(kDismissSearchTextField, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        //pause the video until it comes back to this screen.
        player?.pause()
    }
    
    private func resetPlayerLayerToFullScreen() {
        let bounds = imageView.layer.bounds;
        if let videoPlayerLayer = playerLayer {
            videoPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            videoPlayerLayer.bounds = bounds;
            videoPlayerLayer.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resetPlayerLayerToFullScreen()
    }
    
    private func playVideoForQuiz() {
        if let videoPlayer = player {
            videoPlayer.play()
        } else if let pathForResource = NSBundle.mainBundle().pathForResource("video", ofType: "mp4") {
            let url = NSURL(fileURLWithPath: pathForResource)
            let playerItem = AVPlayerItem(URL: url)
            player = AVPlayer(playerItem: playerItem)
            player?.actionAtItemEnd = .None
            
            playerLayer = AVPlayerLayer(player: player)
            resetPlayerLayerToFullScreen()
            imageView.layer.addSublayer(playerLayer!)
            player?.play()
            
            imageView.bringSubviewToFront(findYourDressButton)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "videoPlayerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: player?.currentItem)
        }
    }
    
    //Loop the video again if reaches end.
    func videoPlayerItemDidReachEnd(notification: NSNotification) {
        let playerItem = notification.object
        playerItem?.seekToTime(kCMTimeZero)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //TODO: Handle custom code related with segue's identifier.
    }

}
