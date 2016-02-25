//
//  FPMQuizMainViewController.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/8/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMQuizMainViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        navigationController?.navigationBarHidden = false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSNotificationCenter.defaultCenter().postNotificationName(kDismissSearchTextField, object: nil)
    }

}
