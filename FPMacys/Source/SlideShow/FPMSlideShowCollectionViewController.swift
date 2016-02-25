//
//  FPMSlideShowCollectionViewController.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/5/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FPMSlideShowCollectionViewCell"

protocol DismissSlideShowDelegate {
    func dismissSlideShow()
}

class FPMSlideShowCollectionViewController: UICollectionViewController,DismissSlideShowDelegate {

    var slideShowDataSource = [String]()
    var rotatingIndex = 0
    var scheduleTimer = NSTimer()
    var homeViewController: FPMHomeViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.whiteColor()

        //set up dataSource
        slideShowDataSource = ["1","2","3","4","5","6"]
        
        // duplicate the last item and put it at first
        // duplicate the first item and put it at last
        let firstItem = slideShowDataSource.first
        let lastItem = slideShowDataSource.last
        
        var workingArray = slideShowDataSource as [String]
        workingArray.insert(lastItem!, atIndex: 0)
        workingArray.append(firstItem!)
        slideShowDataSource = workingArray
        
        // Register cell classes
        collectionView?.registerNib(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        scheduleTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "automaticScroll", userInfo: nil, repeats: true)

//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleNotifications", name: "kFPMSlideShowNotification", object: nil)
    }
    
    func handleNotifications() {
        NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: "launchDismissSlideShow", userInfo: nil, repeats: true)
    }
    
    func launchDismissSlideShow() {
        homeViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        // scroll to the 2nd page, which is showing the first item.
//        struct Tokens {
//            static var token: dispatch_once_t = 0
//        }
//        
//        dispatch_once(&Tokens.token) {
//            self.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: .Left, animated: false)
//        }
//        
//        //Schedule timer for automatic scrolling
//        scheduleTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "automaticScroll", userInfo: nil, repeats: true)
//    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        scheduleTimer.invalidate()
//        dismissViewControllerAnimated(true, completion: nil)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    //MARK: Custom method
    func automaticScroll() {
        if (self.rotatingIndex+1) < self.slideShowDataSource.count {
            collectionView!.performBatchUpdates({ () -> Void in
                self.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forItem: self.rotatingIndex+1, inSection: 0), atScrollPosition: .Left, animated: false)
                self.collectionView?.reloadData()
            }, completion: nil)
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slideShowDataSource.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FPMSlideShowCollectionViewCell
        cell.slideShowImageView.image = UIImage(named: slideShowDataSource[indexPath.row])
        cell.delegate = self
        //Keep current index for rotation
        rotatingIndex = indexPath.row

        //3D animation
//        var transform: CATransform3D = CATransform3DIdentity
//        transform = CATransform3DTranslate(transform, -cell.layer.bounds.size.width, 0.0, 0.0)
//        transform = CATransform3DRotate(transform, -0.01 * (CGFloat)(M_PI/2), 1.0, 0.0, 0.0)
//        cell.layer.transform = CATransform3DTranslate(transform, 0.0, -(-0.01)*(CGFloat)(cell.layer.bounds.size.height), 0.0)
//        cell.layer.opacity = 1.0 - 0.2*fabs(0.07)
        
//        var theTransform:CATransform3D = cell.layer.sublayerTransform;
//        theTransform.m34 = -0.05;
//        cell.layer.sublayerTransform = theTransform;

//        UIView.animateWithDuration(0.05) { () -> Void in
//            var frame = cell.frame
//            frame.size = cell.intrinsicContentSize()
//            cell.frame = frame
//        }
        
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        return self.view.bounds.size//CGSizeMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    }

    // MARK: ScrollView delegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        struct offsetHolder {
            static var lastContentOffsetX:CGFloat = CGFloat(FLT_MIN)
        }
        
        // We can ignore the first time scroll,
        // because it is caused by the call scrollToItemAtIndexPath: in ViewWillAppear
        if CGFloat(FLT_MIN) == offsetHolder.lastContentOffsetX {
            offsetHolder.lastContentOffsetX = scrollView.contentOffset.x
            return
        }

        let currentOffsetX = scrollView.contentOffset.x;
        let currentOffsetY = scrollView.contentOffset.y;
        
        let pageWidth = scrollView.frame.size.width;
        let offset = pageWidth * (CGFloat)(slideShowDataSource.count - 2);
        
        // the first page(showing the last item) is visible and user's finger is still scrolling to the right
        if (currentOffsetX < pageWidth && offsetHolder.lastContentOffsetX > currentOffsetX) {
            offsetHolder.lastContentOffsetX = currentOffsetX + offset;
            scrollView.contentOffset = CGPoint(x: offsetHolder.lastContentOffsetX, y: currentOffsetY);
        }
        // the last page (showing the first item) is visible and the user's finger is still scrolling to the left
        else if (currentOffsetX > offset && offsetHolder.lastContentOffsetX < currentOffsetX) {
            offsetHolder.lastContentOffsetX = currentOffsetX - offset;
            scrollView.contentOffset = CGPoint(x: offsetHolder.lastContentOffsetX, y: currentOffsetY);
        }else{
            offsetHolder.lastContentOffsetX = currentOffsetX;
        }
    }
    
    func dismissSlideShow() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        homeViewController = storyBoard.instantiateViewControllerWithIdentifier("FPMHomeViewController") as? FPMHomeViewController
        presentViewController(homeViewController!, animated: true, completion: nil)
//        NSNotificationCenter.defaultCenter().postNotificationName("kFPMSlideShowNotification", object: nil)
    }

}
