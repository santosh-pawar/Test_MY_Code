//
//  FPMPDPColorCustomView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/17/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMPDPColorCustomView: UIView, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private let colourDataSource = ["White","Black","Cherry Red","Burgundy","Cobalt Blue","Pale Green"]
    private let colourHexCodes = ["#FFFFFF","#000000","#C40000","#800020","#0047ab","#98fb98"]
    
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
        collectionView.registerNib(UINib(nibName: "FPMPDPColorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FPMPDPColorCollectionViewCell")
    }
    
    class func instanceFromNib() -> UIView {
        let colourCustomView = UINib(nibName: "FPMPDPColorCustomView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return colourCustomView
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(kCloseButtonTappedOnPDPNotification, object: nil)
    }
    
    //MARK:- CollectionView DataSource & Delegates
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FPMPDPColorCollectionViewCell", forIndexPath: indexPath) as! FPMPDPColorCollectionViewCell
        cell.colourView.alpha = 1.0
        cell.colourView.backgroundColor = UIColor(hexColor: colourHexCodes[indexPath.row])
        cell.nameLabel.attributedText = NSAttributedString(string: colourDataSource[indexPath.row], attributes: [NSFontAttributeName: FPMFont.FreightDispProLightRegular.withExplicitSize(18), NSForegroundColorAttributeName: UIColor.whiteColor()])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(110, 100)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? FPMPDPColorCollectionViewCell {
            cell.colourView.layer.borderWidth = 1.5
            cell.colourView.layer.borderColor = UIColor.whiteColor().CGColor
            cell.nameLabel.attributedText = NSAttributedString(string: colourDataSource[indexPath.row], attributes: [NSFontAttributeName: FPMFont.FreightDispProMediumItalic.withExplicitSize(18), NSForegroundColorAttributeName: UIColor.whiteColor()])
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? FPMPDPColorCollectionViewCell {
            cell.colourView.layer.borderWidth = 0.0
            cell.colourView.layer.borderColor = UIColor.clearColor().CGColor
            cell.nameLabel.attributedText = NSAttributedString(string: colourDataSource[indexPath.row], attributes: [NSFontAttributeName: FPMFont.FreightDispProLightRegular.withExplicitSize(18), NSForegroundColorAttributeName: UIColor.whiteColor()])
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
