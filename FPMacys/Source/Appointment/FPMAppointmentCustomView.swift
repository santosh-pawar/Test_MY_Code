//
//  FPMAppointmentCustomView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/22/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMAppointmentCustomView: UIView {
    
    
    //MARK:- Outlets, Variables & Action Methods
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(kCloseButtonTappedOnPDPNotification, object: nil)
    }
    
    //MARK:- Life Cycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func instanceFromNib() -> UIView {
        let filterView = UINib(nibName: "FPMAppointmentCustomView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return filterView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.9)
        headerLabel.numberOfLines = 0
        headerLabel.attributedText = "Book an\nappointment".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(50), andColor: UIColor.whiteColor())
        infoLabel.numberOfLines = 0
        
        let attributedInfoLabelText = NSMutableAttributedString()
        attributedInfoLabelText.appendAttributedString("Become a VIP!\n".attributedWithFont(FPMFont.FreightDispProSemiboldRegular.withExplicitSize(30), andColor: UIColor.whiteColor()))
        attributedInfoLabelText.appendAttributedString("Please find ".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(30), andColor: UIColor.whiteColor()))
        attributedInfoLabelText.appendAttributedString("a Sales Associate\n& make ana ppointment\nat your most convenient time\nto get the full experience\nof Fame and Partners through\nthe eyes of a ".attributedWithFont(FPMFont.FreightDispProSemiboldRegular.withExplicitSize(30), andColor: UIColor.whiteColor()))
        attributedInfoLabelText.appendAttributedString("specialized stylist".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(30), andColor: UIColor.whiteColor()))
        
        infoLabel.attributedText = attributedInfoLabelText
    }
    
}
