//
//  FPMPDPBottomCollectionViewCell.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/22/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

typealias TitleImageAndPrice = (title: String, imageName: String, price: String)

class FPMPDPBottomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var titleImageAndPrice: TitleImageAndPrice? = nil {
        didSet {
            switch self.titleImageAndPrice!.title {
            case BottomIconTitles.Colour.rawValue:
                button.setImage(UIImage(named: self.titleImageAndPrice!.imageName), forState: .Normal)
                button.setAttributedTitle(self.titleImageAndPrice!.title.uppercaseString.attributedWithFont(FPMFont.BrandonMedium.withExplicitSize(14), andColor: UIColor.whiteColor()), forState: .Normal)
                setUpButton()
            case BottomIconTitles.Customize.rawValue:
                button.setImage(UIImage(named: self.titleImageAndPrice!.imageName), forState: .Normal)
                button.setAttributedTitle(self.titleImageAndPrice!.title.uppercaseString.attributedWithFont(FPMFont.BrandonMedium.withExplicitSize(14), andColor: UIColor.whiteColor()), forState: .Normal)
                setUpButton()
            case BottomIconTitles.Fit.rawValue:
                button.setImage(UIImage(named: self.titleImageAndPrice!.imageName), forState: .Normal)
                button.setAttributedTitle(self.titleImageAndPrice!.title.uppercaseString.attributedWithFont(FPMFont.BrandonMedium.withExplicitSize(14), andColor: UIColor.whiteColor()), forState: .Normal)
                setUpButton()
            case BottomIconTitles.Order.rawValue:
                button.setImage(UIImage(named: self.titleImageAndPrice!.imageName), forState: .Normal)
                button.setAttributedTitle(self.titleImageAndPrice!.title.uppercaseString.attributedWithFont(FPMFont.BrandonMedium.withExplicitSize(14), andColor: UIColor.whiteColor()), forState: .Normal)
                setUpButton()
            case BottomIconTitles.Share.rawValue:
                button.setImage(UIImage(named: self.titleImageAndPrice!.imageName), forState: .Normal)
                button.setAttributedTitle(self.titleImageAndPrice!.title.uppercaseString.attributedWithFont(FPMFont.BrandonMedium.withExplicitSize(14), andColor: UIColor.whiteColor()), forState: .Normal)
                setUpButton()
            case BottomIconTitles.SubTotal.rawValue:
                button.titleLabel?.numberOfLines = 0
                button.setBackgroundImage(UIImage(named: self.titleImageAndPrice!.imageName), forState: .Normal)
                let subTotal = NSMutableAttributedString()
                subTotal.appendAttributedString("\n$\(self.titleImageAndPrice!.price)".attributedWithFont(FPMFont.BrandonBold.withExplicitSize(14), andColor: UIColor.blackColor()))
                subTotal.appendAttributedString("\n\n\(self.titleImageAndPrice!.title)".uppercaseString.attributedWithFont(FPMFont.BrandonMedium.withExplicitSize(14), andColor: UIColor.blackColor()))
                button.setAttributedTitle(subTotal, forState: .Normal)
                
            default: break
            }
        }
    }
    
    private func setUpButton() {
        // The space between the image and text
        let spacing: CGFloat  = 6.0
        
        // Lower the text and push it left so it appears centered below the image
        let imageSize: CGSize = button.imageView!.frame.size
        button.titleEdgeInsets = UIEdgeInsetsMake(
            0.0, -imageSize.width, -(imageSize.height + spacing), 0.0);
        
        // Raise the image and push it right so it appears centered above the text
        let titleSize: CGSize = button.titleLabel!.frame.size
        button.imageEdgeInsets = UIEdgeInsetsMake(
            -(titleSize.height + spacing), 0.0, 0.0, -titleSize.width);
    }
}
