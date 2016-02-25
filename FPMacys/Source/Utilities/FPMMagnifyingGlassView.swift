//
//  FPMMagnifyingGlassView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/22/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit
import QuartzCore

class FPMMagnifyingGlassView: UIView {
    
    var viewToMagnify: UIView!
    var touchPoint: CGPoint! {
        didSet {
            self.center = CGPointMake(touchPoint.x + touchPointOffset.x, touchPoint.y + touchPointOffset.y)
        }
    }
    
    var touchPointOffset: CGPoint!
    var scale: CGFloat!
    var scaleAtTouchPoint: Bool!
    
    var YPMagnifyingGlassDefaultRadius: CGFloat = 40.0
    var YPMagnifyingGlassDefaultOffset: CGFloat = -40.0
    var YPMagnifyingGlassDefaultScale: CGFloat = 2.0
    
    func initViewToMagnify(viewToMagnify: UIView, touchPoint: CGPoint, touchPointOffset: CGPoint, scale: CGFloat, scaleAtTouchPoint: Bool) {
        
        self.viewToMagnify = viewToMagnify
        self.touchPoint = touchPoint
        self.touchPointOffset = touchPointOffset
        self.scale = scale
        self.scaleAtTouchPoint = scaleAtTouchPoint
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = frame.size.width / 2
        self.layer.masksToBounds = true
        self.touchPointOffset = CGPointMake(0, YPMagnifyingGlassDefaultOffset)
        self.scale = YPMagnifyingGlassDefaultScale
        self.viewToMagnify = nil
        self.scaleAtTouchPoint = true
    }
    
    private func setFrame(frame: CGRect) {
        super.frame = frame
        self.layer.cornerRadius = frame.size.width / 2
    }
    
    override func drawRect(rect: CGRect) {
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextTranslateCTM(context, self.frame.size.width/2, self.frame.size.height/2)
        CGContextScaleCTM(context, self.scale, self.scale)
        CGContextTranslateCTM(context, -self.touchPoint.x, -self.touchPoint.y + (self.scaleAtTouchPoint != nil ? 0 : self.bounds.size.height/2))
        self.viewToMagnify.layer.renderInContext(context)
    }
}
