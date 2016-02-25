//
//  FPMAdminChangePassswordView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/25/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMAdminChangePassswordView: UIView {

    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        oldPasswordTextField.attributedPlaceholder = "Old Password".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(20), andColor: UIColor.whiteColor())
        newPasswordTextField.attributedPlaceholder = "New Password".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(20), andColor: UIColor.whiteColor())
        confirmPasswordTextField.attributedPlaceholder = "Confirm Password".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(20), andColor: UIColor.whiteColor())
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        removeFromSuperview()
    }
    
    @IBAction func submitButtonTapped(sender: AnyObject) {
        if verifyPassword(oldPasswordTextField.text!, newPassword: newPasswordTextField.text!, confirmPassword: confirmPasswordTextField.text!) {
            let successView = UIView(frame: CGRectMake(passwordView.frame.origin.x, passwordView.frame.origin.y, passwordView.frame.width, passwordView.frame.height))
            successView.backgroundColor = UIColor.blackColor()
            
            passwordView.hidden = true
            
            let imageview = UIImageView(frame: CGRectMake(205, 80, 100, 100))
            imageview.image = UIImage(named: "PasswordSuccess")
            imageview.contentMode = .ScaleAspectFit
            successView.addSubview(imageview)
            
            let changedLabel = UILabel(frame: CGRectMake(130, 250, 400, 40))
            changedLabel.attributedText = "Password successfully changed!".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(24), andColor: UIColor.whiteColor())
            successView.addSubview(changedLabel)
            blackView.addSubview(successView)
        }else{
            
        }
    }
    
    class func instanceFromNib() -> UIView {
        let adminView = UINib(nibName: "FPMAdminChangePassswordView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return adminView
    }
    
    private func verifyPassword(oldPassword: String, newPassword: String, confirmPassword: String) -> Bool {
        var returnVal = false
        if let oldPwd = NSUserDefaults.standardUserDefaults().objectForKey(Password) as? String {
            if oldPwd == oldPassword {
                if newPassword == confirmPassword {
                    NSUserDefaults.standardUserDefaults().setObject(newPassword, forKey: Password)
                    returnVal = true
                }else{
                    showAlertWithMessage("Cannot confirm new password.")
                }
            } else {
                showAlertWithMessage("Doesn't match old password.")
            }
        }
        return returnVal
    }
    
    private func showAlertWithMessage(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(okAction)
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
    }

}
