//
//  FPMFilterViewController.swift
//  FPMacys
//
//  Created by Santosh Pawar on 2/11/16.
//  Copyright © 2016 Macy's, Inc. All rights reserved.
//

import UIKit

class FPMFilterViewController: UIViewController {

    @IBOutlet weak var headerCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.01)
        view.opaque = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
