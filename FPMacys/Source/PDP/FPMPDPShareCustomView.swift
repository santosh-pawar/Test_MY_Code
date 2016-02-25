//
//  FPMPDPShareCustomView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/18/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit
import MessageUI

class FPMPDPShareCustomView: UIView, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var firstAndLastNameTextField: UITextField!
    
    @IBOutlet weak var sendButotn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var messageBodyTextView: UITextView!
    
    @IBOutlet weak var emailBodyInfoLabel: UILabel!
    @IBOutlet weak var shareInfoLabel: UILabel!
    
    //MARK:- Factory methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        firstAndLastNameTextField.tintColor = UIColor.whiteColor()
        firstAndLastNameTextField.attributedPlaceholder = NSAttributedString(string:"First & Last Name",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        firstAndLastNameTextField.layer.borderColor = UIColor.whiteColor().CGColor
        firstAndLastNameTextField.layer.borderWidth = 1.5
        emailTextField.layer.borderColor = UIColor.whiteColor().CGColor
        emailTextField.layer.borderWidth = 1.5
        emailTextField.font = FPMFont.FreightDispProMediumItalic.withExplicitSize(20)
        emailTextField.tintColor = UIColor.whiteColor()
        emailTextField.attributedPlaceholder = NSAttributedString(string:"Email Address",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        messageBodyTextView.font = FPMFont.FreightDispProMediumItalic.withExplicitSize(20)
        messageBodyTextView.tintColor = UIColor.whiteColor()
        messageBodyTextView.layer.borderWidth = 1.5
        messageBodyTextView.layer.borderColor = UIColor.whiteColor().CGColor
        messageBodyTextView.backgroundColor = UIColor.clearColor()
        shareInfoLabel.attributedText = NSAttributedString(string:"Email this look to yourself or one of your besties.",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        emailBodyInfoLabel.attributedText = NSAttributedString(string:"Please use this feature with discretion. Macy’s is not responsible for materials, visual or other wise, which may be deemed inappropriate. Macy’s cannot track down any sent, lost or misdirected emails, so please enter information carefully.",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        sendButotn.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(1.0)
    }
    
    class func instanceFromNib() -> UIView {
        let shareCustomView = UINib(nibName: "FPMPDPShareCustomView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return shareCustomView
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(kCloseButtonTappedOnPDPNotification, object: nil)
        
    }
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        
        guard MFMailComposeViewController.canSendMail() else {  return }
        
        let emailViewController = MFMailComposeViewController()
        emailViewController.title = "Email Support Request"
        emailViewController.setSubject("Email Support Request")
        emailViewController.setToRecipients(["santosh.pawar@macys.com"])
        emailViewController.setMessageBody("Message body", isHTML: false)
        emailViewController.mailComposeDelegate = self
        emailViewController.view.tintColor = UIColor.blueColor()
        //        presentViewController(emailViewController, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        let mailComposeController = controller.valueForKeyPath("internal.mailComposeController")
        let sendButtonItem = mailComposeController?.valueForKeyPath("internal.mailComposeView.sendButtonItem")
        mailComposeController?.performSelector("send:", withObject: sendButtonItem)
        //        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK:- Touch Events
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first {
            let point = touch.locationInView(self.superview)
            self.center = point
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        endEditing(true)
    }
}
