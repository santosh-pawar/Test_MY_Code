//
//  FPMCustomTextField.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/25/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit
import CoreGraphics
import QuartzCore

class FPMCustomTextField: UITextField {

    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 10)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 10)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTextFieldLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTextFieldLayouts()
    }

    private func setUpTextFieldLayouts() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.whiteColor().CGColor
        tintColor = UIColor.whiteColor()
        textColor = UIColor.whiteColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tintClearImage()
    }
    var tintedClearImage: UIImage?

    private func tintClearImage() {
        for view in subviews {
            if view is UIButton {
                let button = view as! UIButton
                if let uiImage = button.imageForState(.Highlighted) {
                    if tintedClearImage == nil {
                        tintedClearImage = tintImage(uiImage, color: tintColor)
                    }
                    button.setImage(tintedClearImage, forState: .Normal)
                    button.setImage(tintedClearImage, forState: .Highlighted)
                }
            }
        }
    }

    func tintImage(image: UIImage, color: UIColor) -> UIImage {
        let size = image.size
        
        UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()
        image.drawAtPoint(CGPointZero, blendMode: .Normal, alpha: 1.0)
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextSetBlendMode(context, .SourceIn)
        CGContextSetAlpha(context, 1.0)
        
        let rect = CGRectMake(
            CGPointZero.x,
            CGPointZero.y,
            image.size.width,
            image.size.height)
        CGContextFillRect(UIGraphicsGetCurrentContext(), rect)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tintedImage
    }
}
