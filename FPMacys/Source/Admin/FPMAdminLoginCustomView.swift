//
//  FPMAdminLoginCustomView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/24/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

public let AminUser = "admin"
public let Password = "admin"

class FPMAdminLoginCustomView: UIView {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        if userNameTextField.text?.length() == 0 {
            NSNotificationCenter.defaultCenter().postNotificationName(kLoginFailedNotification, object: "User name field is empty!")
        } else if passwordTextField.text?.length() == 0 {
            NSNotificationCenter.defaultCenter().postNotificationName(kLoginFailedNotification, object: "Password field is empty!")
        } else if userNameTextField.text != AminUser && passwordTextField.text != Password {
            NSNotificationCenter.defaultCenter().postNotificationName(kLoginFailedNotification, object: "Invalid user name/password!")
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName(kLoginButtonTappedNotification, object: nil)
        }
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(kAdminLoginCloseButtonTappedNotification, object: nil)
    }
    
    class func instanceFromNib() -> UIView {
        let adminView = UINib(nibName: "FPMAdminLoginCustomView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return adminView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Admin credentials
        NSUserDefaults.standardUserDefaults().setObject(AminUser, forKey: AminUser)
        
        userNameTextField.font = FPMFont.FreightDispProMediumItalic.withExplicitSize(20)
        userNameTextField.attributedPlaceholder = "Username".attributedWithFont(FPMFont.FreightDispProMediumItalic.withExplicitSize(20), andColor: UIColor.whiteColor())
        userNameTextField.font = FPMFont.FreightDispProMediumItalic.withExplicitSize(20)
        passwordTextField.attributedPlaceholder = "Password".attributedWithFont(FPMFont.FreightDispProMediumItalic.withExplicitSize(20), andColor: UIColor.whiteColor())
        passwordTextField.font = FPMFont.FreightDispProMediumItalic.withExplicitSize(20)
    }
}
