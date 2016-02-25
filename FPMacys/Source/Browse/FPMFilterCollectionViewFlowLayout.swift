//
//  FPMFilterCollectionViewFlowLayout.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/12/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMFilterCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        registerClass(FPMSingleLineReusableView.classForCoder(), forDecorationViewOfKind: "Vertical")
        scrollDirection = .Horizontal
    }
    
    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let nextIndexPath = NSIndexPath(forItem: indexPath.row+1, inSection: indexPath.section)
        let cellAttributes = layoutAttributesForItemAtIndexPath(indexPath)
        let nextCellAttributes = layoutAttributesForItemAtIndexPath(nextIndexPath)
        let layoutAttributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, withIndexPath: indexPath)
        let baseFrame = cellAttributes?.frame
        let nextFrame = nextCellAttributes?.frame
        let strokeWidth = CGFloat(2.0)
        var spaceToNextItem = CGFloat(0.0)
        if nextFrame?.origin.y == baseFrame?.origin.y {
           spaceToNextItem = CGFloat((CGFloat((nextFrame?.origin.x)!)-CGFloat((baseFrame?.origin.x)!)-CGFloat((baseFrame?.size.width)!)))
        }
        
        if elementKind == "Vertical" {
            let padding = CGFloat(5.0)
            
            // Positions the vertical line for this item.
            let x = CGFloat((baseFrame?.origin.x)!+(baseFrame?.size.width)!+CGFloat((spaceToNextItem-strokeWidth)/2))
            layoutAttributes.frame = CGRectMake(x, (baseFrame?.origin.y)!+padding, strokeWidth, (baseFrame?.size.height)!-padding*3)
        }

        layoutAttributes.zIndex = -1
        
        return layoutAttributes
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let baseLayoutAttributes = super.layoutAttributesForElementsInRect(rect)
        var layoutAttributes = baseLayoutAttributes
        for thisLayoutItem in baseLayoutAttributes! {
            if thisLayoutItem.representedElementCategory == .Cell {
                // Adds vertical lines when the item isn't the last in a section or in line.
                if !(indexPathLastInSection(thisLayoutItem.indexPath) || indexPathLastInLine(thisLayoutItem.indexPath)) {
                    let newLayoutItem = layoutAttributesForDecorationViewOfKind("Vertical", atIndexPath: thisLayoutItem.indexPath)
                    layoutAttributes?.append(newLayoutItem!)
                }
            }
        }
        
        return layoutAttributes
    }
    
    func indexPathLastInSection(indexPath: NSIndexPath) -> Bool {
        let lastItem = (collectionView?.dataSource?.collectionView(collectionView!, numberOfItemsInSection: indexPath.section))!-1
        return lastItem == indexPath.row
    }
    
    func indexPathInLastLine(indexPath: NSIndexPath) -> Bool {
        let lastItemRow = (collectionView?.dataSource?.collectionView(collectionView!, numberOfItemsInSection: indexPath.section))!-1
        let lastItem = NSIndexPath(forItem: lastItemRow, inSection: indexPath.section)
        let lastItemAttributes = layoutAttributesForItemAtIndexPath(lastItem)
        let thisItemAttributes = layoutAttributesForItemAtIndexPath(indexPath)

        return lastItemAttributes!.frame.origin.y == thisItemAttributes!.frame.origin.y;
    }
    
    func indexPathLastInLine(indexPath: NSIndexPath) -> Bool {
        let nextIndexPath = NSIndexPath(forItem: indexPath.row+1, inSection: indexPath.section)
        let cellAttributes = layoutAttributesForItemAtIndexPath(indexPath)
        let nextCellAttributes = layoutAttributesForItemAtIndexPath(nextIndexPath)
        
        return !(cellAttributes!.frame.origin.y == nextCellAttributes!.frame.origin.y);
    }
}
