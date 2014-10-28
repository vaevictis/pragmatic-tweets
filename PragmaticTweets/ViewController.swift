//
//  ViewController.swift
//  PragmaticTweets
//
//  Created by vaevictis on 28/10/2014.
//  Copyright (c) 2014 guillaume hammadi. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func handleTweetButtonTapped(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            let tweetVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)

            tweetVC.setInitialText("First tweet from some #swift code. Sweet. #pragsios8")
            
            self.presentViewController(tweetVC, animated: false, completion: {self.completeWithMessage("Roger")})
        } else {
            println("can't send tweet")
        }
    }
    
    func completeWithMessage(str: String) -> Void {
        println("\(str), j'ai fini!!")
    }
}

