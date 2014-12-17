//
//  SizeClassOverrideViewController.swift
//  PragmaticTweets
//
//  Created by vaevictis on 11/12/2014.
//  Copyright (c) 2014 guillaume hammadi. All rights reserved.
//

import UIKit

class SizeClassOverrideViewController: UIViewController {

    var embeddedSplitVC: UISplitViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedSplitViewSegue" {
            self.embeddedSplitVC = segue.destinationViewController as? UISplitViewController
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if size.width > 480.0 {
            let overrideTraits = UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Regular)
            self.setOverrideTraitCollection(overrideTraits, forChildViewController: embeddedSplitVC!)
        } else {
            self.setOverrideTraitCollection(nil, forChildViewController: embeddedSplitVC!)
        }
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
