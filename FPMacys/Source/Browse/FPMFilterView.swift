//
//  FPMFilterView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/11/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit
import JavaScriptCore

class FPMFilterView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK:- Outlets & Variables
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet weak var selectionCollectionView: UICollectionView!
    
    private var topDataSource = [String]()
    private var bottomDataSource = [String]()
    private var colorDataSource  = [String]()
    private var colorNames = ["one","two","three","four","five","six","seven","eight","nine","ten","eleven","twelve","thirteen"]
    private var selectedString = ""
    private var jsonObject: JSON?
    
    //MARK:- Action methods
    @IBAction func closeButtonTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(kCloseFilterButtonTappedNotification, object: nil)
    }
    
    @IBAction func submitButtonTapped(sender: AnyObject) {
        
    }
    
    //MARK:- Factory methods
    override func awakeFromNib() {
        headerCollectionView.registerNib(UINib(nibName: "FPMFilterCollectionReusableView", bundle: nil), forCellWithReuseIdentifier: "FPMFilterCollectionReusableView")
        selectionCollectionView.registerNib(UINib(nibName: "FPMFilterCollectionReusableView", bundle: nil), forCellWithReuseIdentifier: "FPMFilterCollectionReusableView")
        headerCollectionView.backgroundColor = UIColor.clearColor()
        selectionCollectionView.backgroundColor = UIColor.clearColor()
        headerLabel.text = selectedString
        
        //Update JSON Data
        if let path = NSBundle.mainBundle().pathForResource("BrowseFilters", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: .DataReadingMappedIfSafe)
                jsonObject = JSON(data: data)
                if jsonObject != JSON.null {
                    topDataSource = (jsonObject!.dictionaryObject!["Top Values"] as? [String])!
                    bottomDataSource = (jsonObject!.dictionaryObject!["All Styles"] as? [String])!
                } else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func instanceFromNib() -> UIView {
        let filterView = UINib(nibName: "FPMFilterView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return filterView
    }
    
    //MARK:- Private methods
    private func updateCellName(labelName: String, color: UIColor, selected: Bool) -> NSAttributedString {
        let attributedText = NSAttributedString(string: labelName, attributes: [NSFontAttributeName: selected == true ? FPMFont.FreightDispBookItalic.withExplicitSize(25): FPMFont.FreightBigLight.withExplicitSize(25), NSForegroundColorAttributeName: color])
        return attributedText
    }
    
    private func updaeSelectedStringName(headerName: String, selectedName: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: headerName, attributes: [NSFontAttributeName: FPMFont.FreightBigLight.withExplicitSize(25), NSForegroundColorAttributeName: UIColor.whiteColor()])
        let italicText = NSAttributedString(string: selectedName, attributes: [NSFontAttributeName: FPMFont.FreightDispBookItalic.withExplicitSize(25), NSForegroundColorAttributeName: UIColor.whiteColor()])
        attributedText.appendAttributedString(italicText)
        
        return attributedText
    }
    
    //MARK:- CollectionView DataSource and Delegates
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headerCollectionView {
            return topDataSource.count > 0 ? topDataSource.count : 0
        }
        if colorDataSource.count > 0 {
            return colorDataSource.count > 0 ? colorDataSource.count : 0
        }else{
            return bottomDataSource.count > 0 ? bottomDataSource.count : 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FPMFilterCollectionReusableView", forIndexPath: indexPath) as! FPMFilterCollectionReusableView
        
        if collectionView == headerCollectionView {
            print("\(cell.nameLabel.frame)")
            _ = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
            cell.nameLabel.drawTextInRect(CGRectMake(cell.nameLabel.frame.origin.x, cell.nameLabel.frame.origin.y, cell.nameLabel.frame.width, cell.nameLabel.frame.height))
            
            if indexPath.row == 0 {
                cell.selected = true
                cell.nameLabel.attributedText = updateCellName(topDataSource[indexPath.row], color: UIColor.blackColor(), selected: true)
                cell.imageView.image = UIImage(named: "Header_Selection_Cell")
                collectionView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .None)
                selectedString = topDataSource[indexPath.row]
            }else{
                cell.nameLabel.attributedText = updateCellName(topDataSource[indexPath.row], color: UIColor.whiteColor(), selected: false)
            }
        } else {
            if colorDataSource.count > 0 {
                cell.backgroundColor = UIColor(hexColor: colorDataSource[indexPath.row])
                cell.layer.borderColor = UIColor.clearColor().CGColor
                cell.layer.borderWidth = 0.0
                cell.nameLabel.text = ""
            } else {
                cell.nameLabel.attributedText = updateCellName(bottomDataSource[indexPath.row], color: UIColor.whiteColor(), selected: false)
                cell.layer.borderColor = UIColor.whiteColor().CGColor
                cell.layer.borderWidth = 1.0
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(194,50);
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if collectionView == headerCollectionView {
            let cell = headerCollectionView.cellForItemAtIndexPath(indexPath) as! FPMFilterCollectionReusableView
            cell.nameLabel.attributedText = updateCellName(topDataSource[indexPath.row], color: UIColor.blackColor(), selected: true)
            cell.imageView.image = UIImage(named: "Header_Selection_Cell")
            selectedString = topDataSource[indexPath.row]
            headerLabel.attributedText = updateCellName(selectedString, color: UIColor.whiteColor(), selected: true)
            headerLabel.attributedText = updaeSelectedStringName(topDataSource[indexPath.row], selectedName: "")
            
            // update datasource for bottom collectionView
            bottomDataSource = (jsonObject!.dictionaryObject![topDataSource[indexPath.row]] as? [String])!
            if topDataSource[indexPath.row] == "Colors" {
                colorDataSource = bottomDataSource
                bottomDataSource = colorNames
            }else{
                colorDataSource = []
            }
            selectionCollectionView.reloadData()
        }
        
        if collectionView == selectionCollectionView {
            let cell = selectionCollectionView.cellForItemAtIndexPath(indexPath) as! FPMFilterCollectionReusableView
            if colorDataSource.count > 0 {
                cell.layer.borderWidth = 2.0
                cell.layer.borderColor = UIColor.whiteColor().CGColor
                cell.backgroundColor = UIColor(hexColor: colorDataSource[indexPath.row])
            }else{
                cell.nameLabel.attributedText = updateCellName(bottomDataSource[indexPath.row], color: UIColor.blackColor(), selected: true)
                cell.backgroundColor = UIColor.whiteColor()
            }
            headerLabel.attributedText = updaeSelectedStringName("\(selectedString): ", selectedName: bottomDataSource[indexPath.row])
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? FPMFilterCollectionReusableView {
            if collectionView == headerCollectionView {
                cell.nameLabel.attributedText = updateCellName(topDataSource[indexPath.row], color: UIColor.whiteColor(), selected: false)
                selectedString = topDataSource[indexPath.row]
                headerLabel.attributedText = updaeSelectedStringName(selectedString, selectedName: "")
                cell.imageView.image = nil
                cell.backgroundColor = UIColor.clearColor()
            }
            
            if collectionView == selectionCollectionView {
                if colorDataSource.count > 0 {
                    cell.layer.borderWidth = 0.0
                    cell.backgroundColor = UIColor(hexColor: colorDataSource[indexPath.row])
                }else{
                    cell.nameLabel.attributedText = updateCellName(bottomDataSource[indexPath.row], color: UIColor.whiteColor(), selected: false)
                    cell.backgroundColor = UIColor.clearColor()
                }
                headerLabel.attributedText = updaeSelectedStringName("\(selectedString): ", selectedName: bottomDataSource[indexPath.row])
            }
        }
    }
    
    //MARK:- CollectionView Layout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        if collectionView == selectionCollectionView {
            return 10.0
        }
        return 0.0
    }
}
