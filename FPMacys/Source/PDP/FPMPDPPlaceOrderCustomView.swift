//
//  FPMPDPPlaceOrderCustomView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/25/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMPDPPlaceOrderCustomView: UIView {

    @IBOutlet weak var thanksInfoLabel: UILabel!
    @IBOutlet weak var thanksLabel: UILabel!
    
    //MARK:- Factory methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func instanceFromNib() -> UIView {
        let orderCustomView = UINib(nibName: "FPMPDPPlaceOrderCustomView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return orderCustomView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thanksLabel.attributedText = "Thanks, \nYou're Almost Done!".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(50), andColor: UIColor.whiteColor())
        thanksInfoLabel.attributedText = "Please let an associate know you’ve\nshared an order with them.\nThey will help you try your dress on\nand complete your purchase.\nWe hope you enjoyed this experience.".attributedWithFont(FPMFont.FreightDispProLightRegular.withExplicitSize(20), andColor: UIColor.whiteColor())
    }

    @IBAction func closeButtonTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(kClosePlaceOrderButtonTappedOnPDPNotification, object: nil)
    }
    
    //MARK:- Touch Events
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first {
            let point = touch.locationInView(self.superview)
            self.center = point
        }
    }
}
