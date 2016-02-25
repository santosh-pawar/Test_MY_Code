//
//  FPMFilterCollectionReusableView.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/11/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMFilterCollectionReusableView: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = UIColor.clearColor()
    }
    
}
