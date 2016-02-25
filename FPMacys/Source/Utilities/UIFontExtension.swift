//
//  UIFontExtension.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/15/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    //Freight Family
    class func fpmFreightFontWithName(name: String, size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size)!
    }
    
    //Brandon Grotesque Family
    class func fpmBrandonFontWithName(name: String, size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size)!
    }
}

enum FPMFont {
    //Freight Family
    case FreightBigLight
    case FreightDispBookItalic
    case FreightDispProMediumItalic
    case FreightDispProSemiboldRegular
    case FreightDispProBoldRegular
    case FreightDispProLightRegular
    case FreightDispProMediumRegular
    
    //Brandon Family
    case BrandonLight
    case BrandonLightItalic
    case BrandonMedium
    case BrandonMediumItalic
    case BrandonRegular
    case BrandonRegularItalic
    case BrandonBlack
    case BrandonBlackItalic
    case BrandonBold
    case BrandonBoldItalic
    case BrandonThin
    case BrandonThinItalic
    
    func withExplicitSize(size: CGFloat) -> UIFont {
        switch self {
        case .FreightBigLight:
            return .fpmFreightFontWithName("Freight-BigLight",size:size)
        case .FreightDispBookItalic:
            return .fpmFreightFontWithName("Freight-DispBookItalic",size:size)
        case .FreightDispProMediumItalic:
            return .fpmFreightFontWithName("FreightDispProMedium-Italic",size:size)
        case .FreightDispProSemiboldRegular:
            return .fpmFreightFontWithName("FreightDispProSemibold-Regular",size:size)
        case .FreightDispProBoldRegular:
            return .fpmFreightFontWithName("FreightDispProBold-Regular",size:size)
        case .FreightDispProLightRegular:
            return .fpmFreightFontWithName("FreightDispProLight-Regular",size:size)
        case .FreightDispProMediumRegular:
            return .fpmFreightFontWithName("FreightDispProMedium-Regular",size:size)
            
        case .BrandonRegular:
            return .fpmBrandonFontWithName("BrandonGrotesque-Regular",size:size)
        case .BrandonRegularItalic:
            return .fpmBrandonFontWithName("BrandonGrotesque-RegularItalic",size:size)
        case .BrandonLight:
            return .fpmBrandonFontWithName("BrandonGrotesque-Light",size:size)
        case .BrandonLightItalic:
            return .fpmBrandonFontWithName("BrandonGrotesque-LightItalic",size:size)
        case .BrandonMedium:
            return .fpmBrandonFontWithName("BrandonGrotesque-Medium",size:size)
        case .BrandonMediumItalic:
            return .fpmBrandonFontWithName("BrandonGrotesque-MediumItalic",size:size)
        case .BrandonThin:
            return .fpmBrandonFontWithName("BrandonGrotesque-Thin",size:size)
        case .BrandonThinItalic:
            return .fpmBrandonFontWithName("BrandonGrotesque-ThinItalic",size:size)
        case .BrandonBold:
            return .fpmBrandonFontWithName("BrandonGrotesque-Bold",size:size)
        case .BrandonBoldItalic:
            return .fpmBrandonFontWithName("BrandonGrotesque-BoldItalic",size:size)
        case .BrandonBlack:
            return .fpmBrandonFontWithName("BrandonGrotesque-Black",size:size)
        case .BrandonBlackItalic:
            return .fpmBrandonFontWithName("BrandonGrotesque-BlackItalic",size:size)
        }
    }
    
    func withSystemSize(forStyle style: String = UIFontTextStyleBody) -> UIFont {
        let size = UIFont.preferredFontForTextStyle(style).pointSize
        return withExplicitSize(size)
    }
}