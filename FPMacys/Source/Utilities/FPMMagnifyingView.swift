//
//  FPMMagnifyingView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/22/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMMagnifyingView: UIView {
    
    var YPMagnifyingViewDefaultShowDelay: NSTimeInterval = 0.2;
    
    private var magnifyingGlassShowDelay: NSTimeInterval
    
    private var touchTimer: NSTimer!
    
    var magnifyingGlass: FPMMagnifyingGlassView = FPMMagnifyingGlassView()
    
    override init(frame: CGRect) {
        self.magnifyingGlassShowDelay = YPMagnifyingViewDefaultShowDelay
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.magnifyingGlassShowDelay = YPMagnifyingViewDefaultShowDelay
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first {
            
            self.touchTimer = NSTimer.scheduledTimerWithTimeInterval(magnifyingGlassShowDelay, target: self, selector: Selector("addMagnifyingGlassTimer:"), userInfo: NSValue(CGPoint: touch.locationInView(self)), repeats: false)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first {
            self.updateMagnifyingGlassAtPoint(touch.locationInView(self))
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.touchTimer.invalidate()
        self.touchTimer = nil
        
        self.removeMagnifyingGlass()
    }
    
    // MARK: - Private Functions
    
    private func addMagnifyingGlassAtPoint(point: CGPoint) {
        self.magnifyingGlass.viewToMagnify = self as UIView
        self.magnifyingGlass.touchPoint = point
        let selfView: UIView = self as UIView
        selfView.addSubview(self.magnifyingGlass)
        
        self.magnifyingGlass.setNeedsDisplay()
    }
    
    private func removeMagnifyingGlass() {
        self.magnifyingGlass.removeFromSuperview()
    }
    
    private func updateMagnifyingGlassAtPoint(point: CGPoint) {
        self.magnifyingGlass.touchPoint = point
        self.magnifyingGlass.setNeedsDisplay()
    }
    
    func addMagnifyingGlassTimer(timer: NSTimer) {
        let value: AnyObject? = timer.userInfo
        if let point = value?.CGPointValue {
            self.addMagnifyingGlassAtPoint(point)
        }
    }
}
