//
//  ViewController.swift
//  PragmaticTweets
//
//  Created by vaevictis on 28/10/2014.
//  Copyright (c) 2014 guillaume hammadi. All rights reserved.
//

import UIKit
import Social

public class ViewController: UIViewController {

    @IBOutlet public var twitterWebView: UIWebView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.showWebView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func handleTweetButtonTapped(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            let tweetVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            let message = NSBundle.mainBundle().localizedStringForKey("First tweet from some #swift code. Sweet. #pragsios8",
                value: "",
                table: nil)
            
            tweetVC.setInitialText(message)
            
            self.presentViewController(tweetVC, animated: false, completion: {self.completeWithMessage("Roger")})
        } else {
            println("can't send tweet")
        }
    }
    
    @IBAction func handleShowMyTweetsButtonTapped(sender: UIButton) {
        self.showWebView()
    }
    
    func completeWithMessage(str: String) -> Void {
        println("\(str), j'ai fini!!")
    }
    
    func showWebView() {
        self.twitterWebView.loadRequest(NSURLRequest (URL: NSURL (string: "http://twitter.com/ghammadi")!))
    }
}

