//
//  FPMAdminOrdersTableViewCell.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/24/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMAdminOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderTimeLabel: UILabel!
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var colourView: UIView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var bodyTypeLabel: UILabel!
    @IBOutlet weak var skirtLengthLabel: UILabel!
    @IBOutlet weak var customizationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailCustomView: UIView!
    @IBOutlet weak var topSuspendButton: UIButton!
    private let RightArrow = "\u{25B8}"
    @IBOutlet weak var bottomSuspendButton: UIButton!
    private let DownArrow = "\u{25BE}"

    @IBAction func suspendButtonTapped(sender: AnyObject) {
        print("Suspend buton clicked!!!!")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailCustomView.backgroundColor = UIColor.clearColor()
        customerNameLabel.attributedText = "\(RightArrow) Maryanne Jackson".attributedWithFont(FPMFont.FreightDispProLightRegular.withExplicitSize(20), andColor: UIColor.blackColor())
        orderDateLabel.attributedText = "02/24/2016".attributedWithFont(FPMFont.FreightDispProLightRegular.withExplicitSize(20), andColor: UIColor.blackColor())
        orderTimeLabel.attributedText = "08:47 AM".attributedWithFont(FPMFont.FreightDispProLightRegular.withExplicitSize(20), andColor: UIColor.blackColor())
        orderNameLabel.attributedText = setLabelWith("Dress: ", italicText: "Laced Heartline")
        sizeLabel.attributedText = setLabelWith("+ Size: ", italicText: "US 8")
        bodyTypeLabel.attributedText = setLabelWith("+ Body Type: ", italicText: "Strawberry")
        skirtLengthLabel.attributedText = setLabelWith("+ Skirt Length: ", italicText: "Standard")
        customizationLabel.attributedText = setLabelWith("", italicText: "Remove Back Splits, Remove splits, Mini-Dress (no splits) ")
        colourView.backgroundColor = UIColor.redColor()
        colourLabel.attributedText = setLabelWith("Color: ", italicText: "Burdgundy")
        priceLabel.attributedText = "$477.77".attributedWithFont(FPMFont.BrandonBold.withExplicitSize(20), andColor: UIColor.blackColor())
    }
    
    private func setLabelWith(normalText: String, italicText: String) -> NSAttributedString {
        let normalAttrText = NSMutableAttributedString()
        
        normalAttrText.appendAttributedString(normalText.attributedWithFont(FPMFont.FreightDispProLightRegular.withExplicitSize(20), andColor: UIColor.blackColor()))
        normalAttrText.appendAttributedString(italicText.attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(20), andColor: UIColor.blackColor()))
        return normalAttrText.copy() as! NSAttributedString
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
