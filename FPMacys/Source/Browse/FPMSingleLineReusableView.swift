//
//  FPMSingleLineReusableView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/12/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMSingleLineReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
