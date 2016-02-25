//
//  FPMAboutFameAndPartnersViewController.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/8/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMAboutFameAndPartnersViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var browseButton: UIButton!
    
    //MARK:- Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBrowseButton()
        setupQuizButton()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSNotificationCenter.defaultCenter().postNotificationName(kDismissSearchTextField, object: nil)
    }
    
    //MARK:- Private methods
    private func setupBrowseButton() {
        browseButton.layer.borderWidth = 1.0
        browseButton.layer.borderColor = UIColor.grayColor().CGColor
        let attributedTitleForBrowseButton = NSMutableAttributedString()
        attributedTitleForBrowseButton.appendAttributedString("Explore ".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(24), andColor: UIColor.blackColor()))
        attributedTitleForBrowseButton.appendAttributedString("the collection ".attributedWithFont(FPMFont.FreightBigLight.withExplicitSize(24), andColor: UIColor.blackColor()))
        browseButton.setAttributedTitle(attributedTitleForBrowseButton, forState: .Normal)
    }
    
    private func setupQuizButton() {
        quizButton.layer.borderWidth = 1.0
        quizButton.layer.borderColor = UIColor.grayColor().CGColor
        quizButton.titleLabel?.numberOfLines = 0
        quizButton.titleLabel?.textAlignment = .Center
        let attributedTitleForQuizButton = NSMutableAttributedString()
        attributedTitleForQuizButton.appendAttributedString("Get ".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(24), andColor: UIColor.blackColor()))
        attributedTitleForQuizButton.appendAttributedString("inspired &\n".attributedWithFont(FPMFont.FreightDispProLightRegular.withExplicitSize(24), andColor: UIColor.blackColor()))
        attributedTitleForQuizButton.appendAttributedString("find ".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(24), andColor: UIColor.blackColor()))
        attributedTitleForQuizButton.appendAttributedString("the dress for ".attributedWithFont(FPMFont.FreightDispProLightRegular.withExplicitSize(24), andColor: UIColor.blackColor()))
        attributedTitleForQuizButton.appendAttributedString("you".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(24), andColor: UIColor.blackColor()))
        quizButton.setAttributedTitle(attributedTitleForQuizButton, forState: .Normal)
    }    

}
