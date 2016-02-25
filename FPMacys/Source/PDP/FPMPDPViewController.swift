//
//  FPMPDPViewController.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/16/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit
import Foundation

public enum BottomIconTitles: String {
    case Fit = "Fit"
    case Colour = "Colour"
    case Customize = "Customize"
    case SubTotal = "Subtotal"
    case Order = "Order"
    case Share = "Share"
}

class FPMPDPViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK:- Outlets & variables
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var overLaySearchView: FPMOverLaySearchView!
    @IBOutlet weak var magnifyingGlassView: FPMMagnifyingView!
    
    private let thumbnailDataSource = ["Model_1","Model_2","Model_3","Model_4","Model_5"]
    private let bottomCollectionDataSource = ["Fit","Colour","Customize","Subtotal","Order","Share"]
    private var bottomCellIndex = 0
    
    private var fitCustomView: FPMPDPFitCustomView?
    private var colorCustomView: FPMPDPColorCustomView?
    private var customizeCustomView: FPMPDPCustomizeCutomView?
    private var orderCustomView: FPMPDPOrderCustomView?
    private var shareCustomView: FPMPDPShareCustomView?
    private var placeOrderCustomView: FPMPDPPlaceOrderCustomView?
    
    //MARK:- Factory methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMagnifier()
        collectionView.backgroundColor = UIColor.clearColor()
        bottomCollectionView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        collectionView.registerNib(UINib(nibName: "FPMPDPThumbnailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FPMPDPThumbnailCollectionViewCell")
        bottomCollectionView.registerNib(UINib(nibName: "FPMPDPBottomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FPMPDPBottomCollectionViewCell")
        
        modelImageView.image = UIImage(named: thumbnailDataSource[0])
        view.backgroundColor = UIColor(hexColor: "#ececf7")
        magnifyingGlassView.backgroundColor = UIColor(hexColor: "#ececf7")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK:- Action methods
    @IBAction func backButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    private func setupMagnifier() {
        let magnifier = FPMMagnifyingGlassView(frame:CGRectMake(magnifyingGlassView.frame.origin.x, magnifyingGlassView.frame.origin.y, 200, 200))
        magnifier.scale = 2
        self.magnifyingGlassView.magnifyingGlass = magnifier
    }
    
    func closeCustomViewTapped() {
        switch (bottomCollectionDataSource[bottomCellIndex]) {
        case BottomIconTitles.Fit.rawValue:
            unloadCustomView(fitCustomView!)
            fitCustomView = nil
        case BottomIconTitles.Colour.rawValue:
            unloadCustomView(colorCustomView!)
            colorCustomView = nil
        case BottomIconTitles.Customize.rawValue:
            unloadCustomView(customizeCustomView!)
            customizeCustomView = nil
        case BottomIconTitles.Order.rawValue:
            unloadCustomView(orderCustomView!)
            orderCustomView = nil
        case BottomIconTitles.Share.rawValue:
            unloadCustomView(shareCustomView!)
            shareCustomView = nil
        default: break
            
        }
    }
    
    private func unloadCustomView(customview: UIView?) {
        customview?.removeFromSuperview()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kCloseButtonTappedOnPDPNotification, object: nil)
        if let cell = bottomCollectionView.cellForItemAtIndexPath(NSIndexPath(forItem: bottomCellIndex, inSection: 0)) as? FPMPDPBottomCollectionViewCell {
            cell.button.enabled = true
            cell.button.alpha = 1.0
        }
    }
    
    private func loadCustomView(customView: UIView, frame: CGRect) {
        customView.frame = frame
        view.addSubview(customView)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "closeCustomViewTapped", name: kCloseButtonTappedOnPDPNotification, object: nil)
    }
    
    func loadPlaceOrderCustomView() {
        orderCustomView?.removeFromSuperview()
        orderCustomView = nil
        if placeOrderCustomView == nil {
            placeOrderCustomView = FPMPDPPlaceOrderCustomView.instanceFromNib() as? FPMPDPPlaceOrderCustomView
            loadCustomView(placeOrderCustomView!, frame: CGRectMake(130, 120, 510, 620))
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "closePlaceOrderCustomview", name: kClosePlaceOrderButtonTappedOnPDPNotification, object: nil)
        }
    }
    
    func closePlaceOrderCustomview() {
        unloadCustomView(placeOrderCustomView!)
        placeOrderCustomView = nil
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kClosePlaceOrderButtonTappedOnPDPNotification, object: nil)
    }
    
    func editOrderTapped() {
        unloadCustomView(orderCustomView!)
        orderCustomView = nil
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        setCellSelected(indexPath)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kEditOrderButtonTappedOnPDPNotification, object: nil)
    }
    
    private func setCellSelected(indexPath: NSIndexPath) {
        switch (bottomCollectionDataSource[indexPath.row]) {
        case BottomIconTitles.Colour.rawValue:
            if colorCustomView == nil {
                colorCustomView = FPMPDPColorCustomView.instanceFromNib() as? FPMPDPColorCustomView
                loadCustomView(colorCustomView!, frame: CGRectMake(0, 394, view.bounds.size.width, 240))
                colorCustomView?.titleLabel.attributedText = NSAttributedString(string: "Colour", attributes: [NSFontAttributeName: FPMFont.FreightDispBookItalic.withExplicitSize(38.1),NSForegroundColorAttributeName: UIColor.whiteColor()])
            }
        case BottomIconTitles.Fit.rawValue:
            if fitCustomView == nil {
                fitCustomView = FPMPDPFitCustomView.instanceFromNib() as? FPMPDPFitCustomView
                loadCustomView(fitCustomView!, frame: CGRectMake(0, 394, view.bounds.size.width, 260))
                fitCustomView?.titleLabel.attributedText = NSAttributedString(string: "Fit", attributes: [NSFontAttributeName: FPMFont.FreightDispBookItalic.withExplicitSize(38.1), NSForegroundColorAttributeName: UIColor.whiteColor()])
            }
        case BottomIconTitles.Customize.rawValue:
            if customizeCustomView == nil {
                customizeCustomView = FPMPDPCustomizeCutomView.instanceFromNib() as? FPMPDPCustomizeCutomView
                loadCustomView(customizeCustomView!, frame: CGRectMake(0, 394, view.bounds.size.width, 360))
                customizeCustomView?.titleLabel.attributedText = NSAttributedString(string: "Customize", attributes: [NSFontAttributeName: FPMFont.FreightDispBookItalic.withExplicitSize(38.1), NSForegroundColorAttributeName: UIColor.whiteColor()])
            }
        case BottomIconTitles.Order.rawValue:
            if orderCustomView == nil {
                orderCustomView = FPMPDPOrderCustomView.instanceFromNib() as? FPMPDPOrderCustomView
                loadCustomView(orderCustomView!, frame: CGRectMake(130, 120, 510, 750))
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadPlaceOrderCustomView", name: kPlaceOrderButtonTappedOnPDPNotification, object: nil)
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "editOrderTapped", name: kEditOrderButtonTappedOnPDPNotification, object: nil)
            }
        case BottomIconTitles.Share.rawValue:
            if shareCustomView == nil {
                shareCustomView = FPMPDPShareCustomView.instanceFromNib() as? FPMPDPShareCustomView
                loadCustomView(shareCustomView!, frame: CGRectMake(130, 120, 510, 750))
            }
        default: break
        }
        bottomCellIndex = indexPath.row
    }
    
    //MARK:- CollectionView DataSource & Delegates
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bottomCollectionView {
            return bottomCollectionDataSource.count
        }
        return thumbnailDataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == bottomCollectionView {
            let cell = bottomCollectionView.dequeueReusableCellWithReuseIdentifier("FPMPDPBottomCollectionViewCell", forIndexPath: indexPath) as! FPMPDPBottomCollectionViewCell
            cell.titleImageAndPrice = (bottomCollectionDataSource[indexPath.row],"\(bottomCollectionDataSource[indexPath.row])_Icon","477.77")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FPMPDPThumbnailCollectionViewCell", forIndexPath: indexPath) as! FPMPDPThumbnailCollectionViewCell
            cell.thumbnailImageView.image = UIImage(named: thumbnailDataSource[indexPath.row])
            if indexPath.row == 0 {
                cell.layer.borderWidth = 1.0
                cell.layer.borderColor = UIColor.grayColor().CGColor
                cell.selected = true
                collectionView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .None)
            }
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == bottomCollectionView {
            return CGSizeMake(119, 110)
        }
        return CGSizeMake(65, 110)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !(collectionView == bottomCollectionView) {
            let cell = collectionView.cellForItemAtIndexPath(indexPath)
            cell?.layer.borderWidth = 1.0
            cell?.layer.borderColor = UIColor.grayColor().CGColor
            modelImageView.image = UIImage(named: thumbnailDataSource[indexPath.row])
        }else{
            if indexPath.row == 3 {
                //do nothing
            }else{
                let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FPMPDPBottomCollectionViewCell
                cell.button.enabled = false
                cell.button.alpha = 0.4
                
                setCellSelected(indexPath)
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if !(collectionView == bottomCollectionView) {
            let cell = collectionView.cellForItemAtIndexPath(indexPath)
            cell?.layer.borderWidth = 0.0
            cell?.layer.borderColor = UIColor.clearColor().CGColor
        }else{
            NSNotificationCenter.defaultCenter().postNotificationName(kCloseButtonTappedOnPDPNotification, object: nil)
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FPMPDPBottomCollectionViewCell
            cell.button.enabled = true
            cell.button.alpha = 1.0
        }
    }
    
    //MARK:- Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSNotificationCenter.defaultCenter().postNotificationName(kDismissSearchTextField, object: nil)
    }
        
}
