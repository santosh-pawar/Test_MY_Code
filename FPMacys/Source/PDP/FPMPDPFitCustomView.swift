//
//  FPMPDPFitCustomView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/17/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMPDPFitCustomView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    lazy var cellImageView = UIImageView()
    private let topDataSource = ["Size","Body Type","Skirt Length"]
    private let collectionViewCellIdentifier = "FPMPDPFitCustomCollectionViewCell"
    
    //MARK:- Life Cycle & private methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        topCollectionView.backgroundColor = UIColor.clearColor()
        bottomCollectionView.backgroundColor = UIColor.clearColor()
        topCollectionView.registerNib(UINib(nibName: collectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: collectionViewCellIdentifier)
        bottomCollectionView.registerNib(UINib(nibName: collectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: collectionViewCellIdentifier)
    }
    
    class func instanceFromNib() -> UIView {
        let fitCustomView = UINib(nibName: "FPMPDPFitCustomView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return fitCustomView
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(kCloseButtonTappedOnPDPNotification, object: nil)
    }
    
    private func updateBottomCell(cell: FPMPDPFitCustomCollectionViewCell, indexPath: NSIndexPath, selected: Bool) -> FPMPDPFitCustomCollectionViewCell {
        let cellTitle = NSMutableAttributedString()
        if selected == true {
            cellTitle.appendAttributedString("US".attributedWithFont(FPMFont.FreightDispProMediumItalic.withExplicitSize(20), andColor: UIColor.blackColor()))
            cellTitle.appendAttributedString(" \(indexPath.row)".attributedWithFont(FPMFont.BrandonBold.withExplicitSize(20), andColor: UIColor.blackColor()))
            cell.nameLabel.attributedText = cellTitle
            cell.backgroundColor = UIColor.whiteColor()
        } else {
            cellTitle.appendAttributedString("US".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(20), andColor: UIColor.whiteColor()))
            cellTitle.appendAttributedString(" \(indexPath.row)".attributedWithFont(FPMFont.BrandonBold.withExplicitSize(20), andColor: UIColor.whiteColor()))
            cell.nameLabel.attributedText = cellTitle
            cell.backgroundColor = UIColor.clearColor()
        }
        return cell
    }
    
    private func updateTopCell(cell: FPMPDPFitCustomCollectionViewCell, indexPath: NSIndexPath, selected: Bool) {
        if selected == true {
            cellImageView.frame = cell.frame
            cellImageView.image = UIImage(named: "FitTopCell")
            cell.backgroundView = cellImageView
            cell.nameLabel.attributedText = NSAttributedString(string: "\(topDataSource[indexPath.row])", attributes: [NSFontAttributeName: FPMFont.FreightDispProMediumItalic.withExplicitSize(20),NSForegroundColorAttributeName: UIColor.blackColor()])
        } else {
            cell.nameLabel.attributedText = NSAttributedString(string: "\(topDataSource[indexPath.row])", attributes: [NSFontAttributeName: FPMFont.FreightDispProLightRegular.withExplicitSize(20), NSForegroundColorAttributeName: UIColor.whiteColor()])
        }
    }
    
    //MARK:- CollectionView DataSource & Delegates
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionViewCellIdentifier, forIndexPath: indexPath) as! FPMPDPFitCustomCollectionViewCell
        if collectionView == topCollectionView {
            if indexPath.row == 0 {
                topCollectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
                updateTopCell(cell, indexPath: indexPath, selected: true)
            } else {
                updateTopCell(cell, indexPath: indexPath, selected: false)
            }
        } else {
            cell = updateBottomCell(cell, indexPath: indexPath, selected: false)
            cell.layer.borderColor = UIColor.whiteColor().CGColor
            cell.layer.borderWidth = 1.5
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollectionView {
            return topDataSource.count
        }
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == topCollectionView {
            return CGSizeMake(256, 50)
        }
        return CGSizeMake(100, 45)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FPMPDPFitCustomCollectionViewCell
        if collectionView == topCollectionView {
            updateTopCell(cell, indexPath: indexPath, selected: true)
        }else{
            updateBottomCell(cell, indexPath: indexPath, selected: true)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FPMPDPFitCustomCollectionViewCell
        if collectionView == topCollectionView {
            cell.backgroundView = nil
            updateTopCell(cell, indexPath: indexPath, selected: false)
        } else {
            updateBottomCell(cell, indexPath: indexPath, selected: false)
        }
    }
    
    //MARK: Flow Layout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        if collectionView == bottomCollectionView {
            return 10.0
        }
        return 0.0
    }
    
    //MARK:- Touch Events
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first {
            let point = touch.locationInView(self.superview)
            self.center = point
        }
    }
}
