//
//  FPMOverLaySearchView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/10/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

public let kDismissSearchTextField = "DismissSearchTextField"

class FPMOverLaySearchView: UIView {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var headerImageview: UIImageView!

    private var searchTextField: UITextField?
    private lazy var searchSecondaryButton = UIButton()

//    var background: UIColor? = nil {
//        didSet {
//            backgroundColor = background
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(loadViewFromNib())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(loadViewFromNib())
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "dismissSearchTextField", name: kDismissSearchTextField, object: nil)
        
        //add gestureRecognizer for imageView 
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "navigateToHomeScreen")
        headerImageview.addGestureRecognizer(gestureRecognizer)
    }
    
    func navigateToHomeScreen() {
        NSNotificationCenter.defaultCenter().postNotificationName(kNavigateToHomeScreenNotification, object: nil)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "FPMOverLaySearchView", bundle: bundle)
        let searchView = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return searchView
    }

    @IBAction func searchButtonTapped(sender: AnyObject) {
        searchTextField = UITextField(frame: CGRectMake(headerImageview.frame.origin.x, headerImageview.frame.origin.y+3, headerImageview.frame.size.width+50, headerImageview.frame.size.height-10))
        searchTextField!.backgroundColor = UIColor.whiteColor()
        searchTextField!.leftViewMode = .Never
        searchTextField!.rightViewMode = .Never
        searchTextField!.clearButtonMode = .WhileEditing
        searchTextField!.tintColor = UIColor.blueColor()
        searchTextField!.attributedPlaceholder = NSAttributedString(string:"Type Your Dress Here and then Touch the Arrow.",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        searchTextField!.font = UIFont(name: "Freight", size: 25)
        searchTextField!.clearsOnBeginEditing = true
        searchTextField!.becomeFirstResponder()
        
        searchSecondaryButton = UIButton(frame: CGRectMake(searchButton.frame.origin.x, searchButton.frame.origin.y, searchButton.frame.size.width, searchButton.frame.size.height))
        searchSecondaryButton.backgroundColor = UIColor.clearColor()
        searchSecondaryButton.addTarget(self, action: "searchForDress", forControlEvents: .TouchUpInside)
        searchSecondaryButton.setImage(UIImage(named: "Search_Arrow"), forState: .Normal)
        self.addSubview(searchSecondaryButton)
        self.addSubview(searchTextField!)
        
        //hide searchIconed button
        searchButton.hidden = true
    }
    
    func searchForDress() {
        //TODO:Add code for 'search' service call here
        
        //Dismiss the textField once 'arrow' button(searchSecondaryButton) tapped
        dismissSearchTextField()
    }
    
    func dismissSearchTextField() {
        if let searchTextField = searchTextField {
            searchTextField.endEditing(true)
            searchTextField.removeFromSuperview()
            searchSecondaryButton.removeFromSuperview()
            searchButton.hidden = false
        }
    }

//    func addOrDismissTextField() {
//        dismissSearchTextField()
//    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismissSearchTextField()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kDismissSearchTextField, object: nil)
    }
    
}
