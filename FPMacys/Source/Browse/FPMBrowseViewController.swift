//
//  FPMBrowseViewController.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/8/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import Foundation
import UIKit

class FPMBrowseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIPopoverControllerDelegate {
    
    //MARK:- Outlets & Variables
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterByButton: UIButton!
    
    private var filterView: UIView?
    private var sortByTableViewController: FPMSortByTableViewController?
    private var popOverController: UIPopoverController?
    
    lazy var selectedSortOption = ""
    private let sortByTitleDownArrow = "\u{25BE}"
    private let sortByTitleUpArrow = "\u{25B4}"
    
    //MARK:- Factory methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.clearColor()
        //Register the reUsable cell for collectionView
        collectionView.registerNib(UINib(nibName: "FPMProductCollectionReusableView", bundle: nil), forCellWithReuseIdentifier: "FPMProductCollectionReusableView")
        
        //Add gestureRecognizer for collectionView
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "collectionViewTouched")
        gestureRecognizer.cancelsTouchesInView = false
        collectionView.addGestureRecognizer(gestureRecognizer)
        
        //setup Sort button
        sortButton.layer.borderColor = UIColor.grayColor().CGColor
        sortButton.layer.borderWidth = 1.5
//        sortButton.setAttributedTitle(NSAttributedString(string: "Sort By"+"\t\t\t\(sortByTitleDownArrow)", attributes: [NSFontAttributeName:FPMFont.FreightDispProLight.withExplicitSize(19), NSForegroundColorAttributeName: UIColor.fpmGrayColor()]), forState: .Normal)
        sortButton.setAttributedTitle(NSAttributedString(string: "Sort By"+"\t\t\t\(sortByTitleDownArrow)", attributes: [NSFontAttributeName:FPMFont.FreightBigLight.withExplicitSize(19), NSForegroundColorAttributeName: UIColor.grayColor()]), forState: .Normal)

    }
    
    //MARK:- Action methods
    @IBAction func filterByButtonTapped(sender: AnyObject) {
        filterView = FPMFilterView.instanceFromNib()
        filterView!.frame = CGRectMake(filterByButton.frame.origin.x, filterByButton.frame.origin.y, view.bounds.size.width, view.frame.size.height-80)
        filterView!.backgroundColor = UIColor.clearColor()
        view.addSubview(filterView!)
        filterByButton.hidden = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "closeFilter", name: kCloseFilterButtonTappedNotification, object: nil)
    }
    
    @IBAction func sortByButtonTapped(sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        sortByTableViewController = storyBoard.instantiateViewControllerWithIdentifier("FPMSortByTableViewController") as? FPMSortByTableViewController
        if let sortByTableViewController = sortByTableViewController {
            popOverController = UIPopoverController(contentViewController: sortByTableViewController)
            popOverController!.popoverContentSize = CGSizeMake(170, 200)
            popOverController!.delegate = self
            
            popOverController?.passthroughViews = [sortByTableViewController.tableView]
            popOverController!.presentPopoverFromRect(sortButton.frame, inView: self.view, permittedArrowDirections: .Up, animated: true)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "sortOptionDidSelect:", name: kSortOptionDidSelect, object: nil)
            sortButton.setAttributedTitle(NSAttributedString(string: "Sort By"+"\t\t\t\(sortByTitleUpArrow)", attributes: [NSFontAttributeName:FPMFont.FreightBigLight.withExplicitSize(19), NSForegroundColorAttributeName: UIColor.grayColor()]), forState: .Normal)
        }
    }
    
    func sortOptionDidSelect(notificationObect: NSNotification) {
        selectedSortOption = notificationObect.object as! String
        sortButton.setAttributedTitle(NSAttributedString(string: "\(selectedSortOption)"+"\t\t\(sortByTitleDownArrow)", attributes: [NSFontAttributeName:FPMFont.FreightBigLight.withExplicitSize(19), NSForegroundColorAttributeName: UIColor.grayColor()]), forState: .Normal)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kSortOptionDidSelect, object: nil)
    }
    
    func popoverControllerShouldDismissPopover(popoverController: UIPopoverController) -> Bool {
        return true
    }
    
    func closeFilter() {
        filterView?.removeFromSuperview()
        filterByButton.hidden = false
    }
    
    func collectionViewTouched() {
        //Dismiss searchTextfield if it is presented
        NSNotificationCenter.defaultCenter().postNotificationName(kDismissSearchTextField, object: nil)
    }
    
    //MARK:- CollectionView DataSource & Delegates
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FPMProductCollectionReusableView", forIndexPath: indexPath) as! FPMProductCollectionReusableView
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(230, 435)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let pdpViewController = storyBoard.instantiateViewControllerWithIdentifier("FPMPDPViewController") as? FPMPDPViewController
        navigationController?.pushViewController(pdpViewController!, animated: true)
    }
    
    //MARK:- REST Service Call
    func pdpDetailServiceCall() {
        let postEndpoint: String = "http://tibanp156.federated.fds:37000/GetProducts"
        guard let url = NSURL(string: postEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET on /posts/1")
                print(error)
                return
            }
            // parse the result as JSON, since that's what the API provides
            let post: NSDictionary
            do {
                post = try NSJSONSerialization.JSONObjectWithData(responseData,
                    options: []) as! NSDictionary
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            // now we have the post, let's just print it to prove we can access it
            print("The post is: " + post.description)
            
            // the post object is a dictionary
            // so we just access the title using the "title" key
            // so check for a title and print it if we have one
            if let postTitle = post["title"] as? String {
                print("The title is: " + postTitle)
            }
        })
        task.resume()
    }
    
    //MARK:- Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSNotificationCenter.defaultCenter().postNotificationName(kDismissSearchTextField, object: nil)
    }
}
