//
//  FPMPDPOrderCustomView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/23/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMPDPOrderCustomView: UIView {
    
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var bodyTypeLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var colourView: UIView!
    @IBOutlet weak var customizationLabel: UILabel!
    @IBOutlet weak var firstAndLastNameTextField: UITextField!
    
    //MARK:- Factory methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    class func instanceFromNib() -> UIView {
        let orderCustomView = UINib(nibName: "FPMPDPOrderCustomView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return orderCustomView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sizeLabel.attributedText = setLabelWith("Size: ", italicText: "US 6")
        bodyTypeLabel.attributedText = setLabelWith("Body Type: ", italicText: "Pear")
        lengthLabel.attributedText = setLabelWith("Length: ", italicText: "Standard")
        colourLabel.attributedText = setLabelWith("Colour: ", italicText: "Marine Blue")
        colourView.backgroundColor = UIColor.blueColor()
        customizationLabel.attributedText = setLabelWith("", italicText: "Remove back splits")
        firstAndLastNameTextField.layer.borderColor = UIColor.whiteColor().CGColor
        firstAndLastNameTextField.layer.borderWidth = 1.0
        firstAndLastNameTextField.font = FPMFont.FreightDispProMediumItalic.withExplicitSize(20)
        firstAndLastNameTextField.textColor = UIColor.whiteColor()
        firstAndLastNameTextField.attributedPlaceholder = "First & Last Name".attributedWithFont(FPMFont.FreightDispProMediumItalic.withExplicitSize(20), andColor: UIColor.whiteColor())
        firstAndLastNameTextField.tintColor = UIColor.whiteColor()
        editButton.layer.borderColor = UIColor.whiteColor().CGColor
        editButton.layer.borderWidth = 1.0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        endEditing(true)
    }
    
    private func setLabelWith(normalText: String, italicText: String) -> NSAttributedString {
        let normalAttrText = NSMutableAttributedString()
        
        normalAttrText.appendAttributedString(normalText.attributedWithFont(FPMFont.FreightDispProLightRegular.withExplicitSize(30), andColor: UIColor.whiteColor()))
        normalAttrText.appendAttributedString(italicText.attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(30), andColor: UIColor.whiteColor()))
        return normalAttrText.copy() as! NSAttributedString
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(kCloseButtonTappedOnPDPNotification, object: nil)
    }

    @IBAction func placeOrderButtonTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(kPlaceOrderButtonTappedOnPDPNotification, object: nil)
    }
    
    @IBAction func editOrderButtonTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(kEditOrderButtonTappedOnPDPNotification, object: nil)
    }
    
    //MARK:- Touch Events
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first {
            let point = touch.locationInView(self.superview)
            self.center = point
        }
    }
}
