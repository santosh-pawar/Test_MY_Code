//
//  StringExtension.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/19/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
    
    func length() -> Int {
        return self.characters.count
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    func substring(location:Int, length:Int) -> String! {
        return (self as NSString).substringWithRange(NSMakeRange(location, length))
    }
    
    subscript(index: Int) -> String! {
        get {
            return self.substring(index, length: 1)
        }
    }
    
    func subStringBeforeString(string: String) -> String {
        let index: String.Index = self.startIndex.advancedBy(self.location(string)+1)
        let stringToIndex = self.substringToIndex(index)
        let subStringValue = stringToIndex.substring(0, length: stringToIndex.length())
        
        return subStringValue
    }
    
    func subStringAfterString(string: String) -> String {
        let index: String.Index = self.startIndex.advancedBy(self.location(string)+1)
        let stringFromIndex = self.substringFromIndex(index)
        let subStringValue = stringFromIndex.substring(0, length: stringFromIndex.length())
        
        return subStringValue
    }
    
    func location(other: String) -> Int {
        return (self as NSString).rangeOfString(other).location
    }
    
    func contains(other: String) -> Bool {
        return (self as NSString).containsString(other)
    }
    
    func isNumeric() -> Bool {
        return (self as NSString).rangeOfCharacterFromSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).location == NSNotFound
    }
    
    func isZipCode() -> Bool{
        
        let scanner = NSScanner(string: self)
        return scanner.scanInteger(nil) && scanner.atEnd
    }
    
    func localizedWithComment(comment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: comment)
    }
    
    func localizedWithArguments(arguments:[CVarArgType]) -> String {
        return String(format: NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: ""), arguments: arguments)
    }
    
    var boolValueFromJSON: Bool? {
        switch self.lowercaseString {
        case "yes", "1", "true":
            return true
        case "no", "0", "false":
            return false
        default:
            return nil
        }
    }
    
    var attributed: NSAttributedString {
        return NSAttributedString(string: self)
    }
    
    func attributedWithAttributes(attributes: [String : AnyObject]?) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    func attributedWithFont(font: UIFont, andColor color: UIColor? = nil) -> NSAttributedString {
        var attributes: [String : AnyObject] = [NSFontAttributeName: font]
        attributes[NSForegroundColorAttributeName] = color
        return attributedWithAttributes(attributes)
    }
    
    var mutableAttributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
    
    func isEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "\\w+@[a-zA-Z_]+?\\.[a-zA-Z]{2,6}", options: [.CaseInsensitive])
        return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count)) != nil
    }
    
}
