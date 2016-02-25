//
//  FPMSortByTableViewController.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/19/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMSortByTableViewController: UITableViewController {
    
    private let sortOptions = ["Sort By","Price High", "Price Low", "What\'s New"]
    lazy var selectedSortOption = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "sortOptionCell")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sortOptionCell", forIndexPath: indexPath)
        cell.textLabel?.attributedText = (NSAttributedString(string: "\(sortOptions[indexPath.row])", attributes: [NSFontAttributeName:FPMFont.FreightBigLight.withExplicitSize(19), NSForegroundColorAttributeName: UIColor.grayColor()]))
        cell.selectionStyle = .None
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortOptions.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row != 0 {
            selectedSortOption = sortOptions[indexPath.row]
            NSNotificationCenter.defaultCenter().postNotificationName(kSortOptionDidSelect, object: selectedSortOption)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsZero
        }
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins = false
        }
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }
}
