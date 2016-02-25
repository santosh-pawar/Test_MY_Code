//
//  FPMAdminListOfOrdersCustomView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/24/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMAdminListOfOrdersCustomView: UIView, UITableViewDataSource, UITableViewDelegate {

    private let DownArrow = "\u{25BE}"
    private let RightArrow = "\u{25B8}"
    private var selectedRowIndex: Int?
    private var expanded = false
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func changePasswordButtonTapped(sender: AnyObject) {
        let passwordView = FPMAdminChangePassswordView.instanceFromNib() as? FPMAdminChangePassswordView
        passwordView?.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, self.frame.height)
        passwordView?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
        addSubview(passwordView!)
    }
    
//    func closeChangePasswordView() {
//        changePasswordBackgroundView.removeFromSuperview()
//    }
//    
//    private func addChanePasswordView() -> UIView {
//        changePasswordView = UIView(frame:CGRectMake(130, 120, 510, 440))
//        changePasswordView.backgroundColor = UIColor.blackColor()
//        
//        let closeButton = UIButton(frame: CGRectMake(435, 35, 45, 45))
//        closeButton.setBackgroundImage(UIImage(named: "Close_Icon"), forState: .Normal)
//        closeButton.addTarget(self, action: "closeChangePasswordView", forControlEvents: UIControlEvents.TouchUpInside)
//        changePasswordView.addSubview(closeButton)
//        
//        let oldPasswordTextField = FPMCustomTextField(frame: CGRectMake(60, 140, 385, 60))
//        oldPasswordTextField.attributedPlaceholder = "Old Password".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(20), andColor: UIColor.whiteColor())
//        oldPasswordTextField.secureTextEntry = true
//        changePasswordView.addSubview(oldPasswordTextField)
//        
//        let newPasswordTextField = FPMCustomTextField(frame: CGRectMake(60, 210, 385, 60))
//        newPasswordTextField.attributedPlaceholder = "New Password".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(20), andColor: UIColor.whiteColor())
//        newPasswordTextField.secureTextEntry = true
//        changePasswordView.addSubview(newPasswordTextField)
//
//        
//        let confirmNewPasswordTextField = FPMCustomTextField(frame: CGRectMake(60, 280, 385, 60))
//        confirmNewPasswordTextField.attributedPlaceholder = "Confirm Password".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(20), andColor: UIColor.whiteColor())
//        confirmNewPasswordTextField.secureTextEntry = true
//        changePasswordView.addSubview(confirmNewPasswordTextField)
//
//        let submitButton = UIButton(frame: CGRectMake(130, 360, 260, 45))
//        submitButton.backgroundColor = UIColor.whiteColor()
//        submitButton.setAttributedTitle("Submit".attributedWithFont(FPMFont.FreightDispProLightRegular.withExplicitSize(24), andColor: UIColor.blackColor()), forState: .Normal)
//        submitButton.addTarget(self, action: "changePassword", forControlEvents: .TouchUpInside)
//        changePasswordView.addSubview(submitButton)
//        
//        let nameLabel = UILabel(frame: CGRectMake(50, 50, 400, 50))
//        nameLabel.textAlignment = .Center
//        nameLabel.attributedText = "Change Password".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(48), andColor: UIColor.whiteColor())
//        changePasswordView.addSubview(nameLabel)
//        
//        oldPassword = oldPasswordTextField.text!
//        newPassword = newPasswordTextField.text!
//        confirmPassword = confirmNewPasswordTextField.text!
//        
//        return changePasswordView
//    }
//    
//    func textFieldDidEndEditing(textField: UITextField) {
//        
//    }
    
    private func verifyPassword(oldPassword: String, newPassword: String, confirmPassword: String) -> Bool {
        if let oldPwd = NSUserDefaults.standardUserDefaults().objectForKey(Password) as? String {
            if oldPwd == oldPassword {
                if newPassword == confirmPassword {
                    NSUserDefaults.standardUserDefaults().setObject(newPassword, forKey: Password)
                    return true
                }else{
                    return false
                }
            } else {
                return false
            }
        }else{
            return false
        }
    }
    
//    func changePassword() {
//        let successView = UIView(frame: CGRectMake(changePasswordView.frame.origin.x, changePasswordView.frame.origin.y, changePasswordView.frame.width, changePasswordView.frame.height))
//        successView.backgroundColor = UIColor.blackColor()
//        changePasswordView.removeFromSuperview()
//        
//        let nameLabel = UILabel(frame: CGRectMake(50, 50, 400, 50))
//        nameLabel.textAlignment = .Center
//        nameLabel.attributedText = "Change Password".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(48), andColor: UIColor.whiteColor())
//        successView.addSubview(nameLabel)
//        
//        let closeButton = UIButton(frame: CGRectMake(435, 35, 45, 45))
//        closeButton.setBackgroundImage(UIImage(named: "Close_Icon"), forState: .Normal)
//        closeButton.addTarget(self, action: "closeChangePasswordView", forControlEvents: UIControlEvents.TouchUpInside)
//        successView.addSubview(closeButton)
//        
//        let imageview = UIImageView(frame: CGRectMake(205, 175, 100, 100))
//        imageview.image = UIImage(named: "PasswordSuccess")
//        imageview.contentMode = .ScaleAspectFit
//        successView.addSubview(imageview)
//        
//        let changedLabel = UILabel(frame: CGRectMake(130, 350, 400, 40))
//        changedLabel.attributedText = "Password successfully changed!".attributedWithFont(FPMFont.FreightDispBookItalic.withExplicitSize(24), andColor: UIColor.whiteColor())
//        successView.addSubview(changedLabel)
//        changePasswordBackgroundView.addSubview(successView)
//    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(kAdminScreenCloseButtonTappedNotification, object: nil)
    }
        
    class func instanceFromNib() -> UIView {
        let adminView = UINib(nibName: "FPMAdminListOfOrdersCustomView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return adminView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.registerNib(UINib(nibName: "FPMAdminOrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "FPMAdminOrdersTableViewCell")
        tableView.separatorColor = UIColor.clearColor()
    }
    
    //MARK:- TableView DataSource & Delegates
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FPMAdminOrdersTableViewCell", forIndexPath: indexPath) as! FPMAdminOrdersTableViewCell
        cell.detailCustomView.hidden = true
        
        //Set alternate background color for cells
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.whiteColor()
        }else{
            cell.backgroundColor = UIColor.lightGrayColor()
        }
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if selectedRowIndex == selectedRowIndex && indexPath.row == selectedRowIndex {
            return 400.0
        }
        return 50.0
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FPMAdminOrdersTableViewCell
        setCellSelected(cell, indexPath: indexPath, selected: false)
    }
    
    private func setCellSelected(cell: FPMAdminOrdersTableViewCell, indexPath:NSIndexPath, selected: Bool) {
        if selected == true {
            cell.customerNameLabel.attributedText = "\(DownArrow) Maryanne Jackson".attributedWithFont(FPMFont.FreightDispProLightRegular.withExplicitSize(20), andColor: UIColor.blackColor())
            cell.topSuspendButton.hidden = true
            cell.detailCustomView.hidden = false
            tableView.beginUpdates()
            tableView.endUpdates()
            expanded = true
        }else{
            cell.customerNameLabel.attributedText = "\(RightArrow) Maryanne Jackson".attributedWithFont(FPMFont.FreightDispProLightRegular.withExplicitSize(20), andColor: UIColor.blackColor())
            cell.topSuspendButton.hidden = false
            cell.detailCustomView.hidden = true
            tableView.beginUpdates()
            tableView.endUpdates()
            expanded = false
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRowIndex = indexPath.row
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FPMAdminOrdersTableViewCell
        if selectedRowIndex == selectedRowIndex && indexPath.row == selectedRowIndex && expanded == false {
            setCellSelected(cell, indexPath: indexPath, selected: true)
        }else{
            selectedRowIndex = 99999
            setCellSelected(cell, indexPath: indexPath, selected: false)
        }
    }
}
