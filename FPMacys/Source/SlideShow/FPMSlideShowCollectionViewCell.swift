//
//  FPMSlideShowCollectionViewCell.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/5/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMSlideShowCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var slideShowImageView: UIImageView!
    var delegate: DismissSlideShowDelegate?

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        delegate?.dismissSlideShow()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
