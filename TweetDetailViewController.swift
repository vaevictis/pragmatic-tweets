//
//  TweetDetailViewController.swift
//  PragmaticTweets
//
//  Created by vaevictis on 5/11/2014.
//  Copyright (c) 2014 guillaume hammadi. All rights reserved.
//

import UIKit
import MapKit

class TweetDetailViewController: UIViewController, TwitterAPIRequestDelegate {

    var tweetIdString: String? {
        didSet {
            reloadTweetDetails()
        }
    }
    
    @IBOutlet var userImageButton: UIButton!
    @IBOutlet var userRealNameLabel: UILabel!
    @IBOutlet var userScreenNameLabel: UILabel!
    @IBOutlet var tweetTextLabel: UILabel!
    @IBOutlet var tweetLocalMapView: MKMapView!
    
    func reloadTweetDetails() {
        if tweetIdString == nil {return}
        let twitterParams = ["id": tweetIdString!]
        let twitterRequest = TwitterAPIRequest()
        let twitterAPIURL = NSURL (string: "https://api.twitter.com/1.1/statuses/show.json")
        twitterRequest.sendTwitterRequest(twitterAPIURL, params: twitterParams, delegate: self)
    }
    
    func handleTwitterData(data: NSData!,
        urlResponse: NSHTTPURLResponse!,
        error: NSError!,
        fromRequest: TwitterAPIRequest!) {
            if let dataValue = data {
                let jsonString = NSString (data: data, encoding: NSUTF8StringEncoding)
                var parseError: NSError? = nil
                
                let jsonObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(dataValue, options: NSJSONReadingOptions(0), error: &parseError)
                
                if let errorValue = parseError { return }
                    
                if let tweetDict = jsonObject as? Dictionary<String, AnyObject> {
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        let userDict = tweetDict["user"] as NSDictionary
                        
                        self.userRealNameLabel.text = userDict["name"] as? NSString
                        self.userScreenNameLabel.text = userDict["screen_name"] as? NSString
                        self.tweetTextLabel.text = tweetDict["text"] as? NSString
                        
                        let userImageURL = NSURL (string: userDict["profile_image_url"] as NSString!)
                        
                        self.userImageButton.setTitle(nil, forState: UIControlState.Normal)
                        self.userImageButton.setImage(UIImage(data: NSData(contentsOfURL: userImageURL!)!), forState: UIControlState.Normal)
                    })
                }
            } else {
                println("handleTwitterData received no data")
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        reloadTweetDetails()
        
    }

    
    // MARK: - Navigation
    
    
    // MARK: Memory management
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
}
