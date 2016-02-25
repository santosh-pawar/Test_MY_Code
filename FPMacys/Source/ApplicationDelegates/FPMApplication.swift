//
//  FPMApplication.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/5/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

//Constants
private let kApplicationTimeoutInMinutes = 2

//Notifications
public let kApplicationDidTimeoutNotification = "ApplicationDidTimeoutNotification"
public let kLaunchHomeScreenOrPreviousScreen = "LaunchHomeScreenOrPreviousScreen"
public let kNavigateToHomeScreenNotification = "NavigateToHomeScreenNotification"
public let kCloseFilterButtonTappedNotification = "CloseFilterButtonTappedNotification"
public let kCloseButtonTappedOnPDPNotification = "CloseButtonTappedOnPDPNotification"
public let kPlaceOrderButtonTappedOnPDPNotification = "PlaceOrderButtonTappedOnPDPNotification"
public let kEditOrderButtonTappedOnPDPNotification = "kEditOrderButtonTappedOnPDPNotification"
public let kClosePlaceOrderButtonTappedOnPDPNotification = "kClosePlaceOrderButtonTappedOnPDPNotification"
public let kAdminLoginCloseButtonTappedNotification = "AdminLoginCloseButtonTappedNotification"
public let kAdminScreenCloseButtonTappedNotification = "AdminScreenCloseButtonTappedNotification"
public let kLoginButtonTappedNotification = "LoginButtonTappedNotification"
public let kSortOptionDidSelect = "SortOptionDidSelect"
public let kLoginFailedNotification = "LoginFailedNotification"
//Keys
public let kAdminLoginDidCloseKey = "kAdminLoginDidCloseKey"

class FPMApplication: UIApplication {
    
    var idleTimer: NSTimer?
    
    override func sendEvent(event: UIEvent) {
        super.sendEvent(event)
        if idleTimer != nil {
           resetIdleTimer()
        }
        
        if let allTouches = event.allTouches() {
            for touch in allTouches.enumerate() {
                if touch.element.phase == .Began {
                    resetIdleTimer()
                }
            }
        }
    }
    
    func resetIdleTimer() {
        if (idleTimer != nil) {
            idleTimer?.invalidate()
        }
        
        let timeout = kApplicationTimeoutInMinutes*60
        idleTimer = NSTimer.scheduledTimerWithTimeInterval(Double(timeout), target: self, selector: "idleTimerExceeded", userInfo: nil, repeats: false)
    }
    
    func idleTimerExceeded() {
        NSNotificationCenter.defaultCenter().postNotificationName(kApplicationDidTimeoutNotification, object: nil)
    }
}
