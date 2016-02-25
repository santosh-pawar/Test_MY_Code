//
//  FPMPDPCustomizeCutomView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/17/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMPDPCustomizeCutomView: UIView, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    private let blackImagesArray = ["Custom_Black_1","Custom_Black_2","Custom_Black_3"]
    private let whiteImagesArray = ["Custom_White_1","Custom_White_2","Custom_White_3"]
    private let dressNames = ["Mini-Dress(no splits)","Remove Splits","Remove back splits"]
    
    //MARK:- Factory methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor=UIColor.blackColor().colorWithAlphaComponent(0.6)
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerNib(UINib(nibName: "FPMPDPCustomizeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FPMPDPCustomizeCollectionViewCell")
    }
    
    class func instanceFromNib() -> UIView {
        let customizeCustomView = UINib(nibName: "FPMPDPCustomizeCutomView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return customizeCustomView
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(kCloseButtonTappedOnPDPNotification, object: nil)
    }
    
    //MARK:- CollectionView DataSource & Delegates
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FPMPDPCustomizeCollectionViewCell", forIndexPath: indexPath) as! FPMPDPCustomizeCollectionViewCell
        cell.imageView.image = UIImage(named: "\(blackImagesArray[indexPath.row])")
        cell.nameLabel.attributedText = NSAttributedString(string: dressNames[indexPath.row], attributes: [NSFontAttributeName: FPMFont.FreightDispProLightRegular.withExplicitSize(18), NSForegroundColorAttributeName: UIColor.whiteColor()])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dressNames.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(185, 240)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? FPMPDPCustomizeCollectionViewCell {
            cell.imageView.image = UIImage(named: "\(whiteImagesArray[indexPath.row])")
            cell.nameLabel.attributedText = NSAttributedString(string: dressNames[indexPath.row], attributes: [NSFontAttributeName: FPMFont.FreightDispProMediumItalic.withExplicitSize(18), NSForegroundColorAttributeName: UIColor.whiteColor()])
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? FPMPDPCustomizeCollectionViewCell {
            cell.imageView.image = UIImage(named: "\(blackImagesArray[indexPath.row])")
            cell.nameLabel.attributedText = NSAttributedString(string: dressNames[indexPath.row], attributes: [NSFontAttributeName: FPMFont.FreightDispProLightRegular.withExplicitSize(18), NSForegroundColorAttributeName: UIColor.whiteColor()])
        }
    }
    
    //MARK: Flow Layout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10.0
    }
    
    //MARK:- Touch Events
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first {
            let point = touch.locationInView(self.superview)
            self.center = point
        }
    }
}
