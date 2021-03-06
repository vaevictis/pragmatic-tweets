//
//  UserDetailViewController.swift
//  PragmaticTweets
//
//  Created by vaevictis on 7/11/2014.
//  Copyright (c) 2014 guillaume hammadi. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, TwitterAPIRequestDelegate {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userRealNameLabel: UILabel!
    @IBOutlet var userScreenNameLabel: UILabel!
    @IBOutlet var userLocationLabel: UILabel!
    @IBOutlet var userDescriptionLabel: UILabel!
    
    var screenName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if screenName == nil { return }
        
        let twitterRequest = TwitterAPIRequest()
        let twitterParams = ["screen_name": screenName!]
        let twitterAPIURL = NSURL (string: "https://api.twitter.com/1.1/users/show.json")
        
        twitterRequest.sendTwitterRequest(twitterAPIURL,
            params: twitterParams,
            delegate: self)
    }

    func handleTwitterData(data: NSData!,
        urlResponse: NSHTTPURLResponse!,
        error: NSError!,
        fromRequest: TwitterAPIRequest!) {
            if let dataValue = data {
                let jsonString = NSString (data: data, encoding: NSUTF8StringEncoding)
                var parseError : NSError? = nil
                let jsonObject : AnyObject? = NSJSONSerialization.JSONObjectWithData(dataValue, options: NSJSONReadingOptions(0), error: &parseError)
                
                if let errorValue = parseError { return }
                
                if let tweetDict = jsonObject as? Dictionary<String, AnyObject> {
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        self.userRealNameLabel.text = tweetDict["name"] as? NSString
                        self.userScreenNameLabel.text = tweetDict["screen_name"] as? NSString
                        self.userLocationLabel.text = tweetDict["location"] as? NSString
                        self.userDescriptionLabel.text = tweetDict["description"] as? NSString
                        
                        let userImageURL = NSURL(string: tweetDict ["profile_image_url"] as NSString!)
                        self.userImageView.image = UIImage(data: NSData(contentsOfURL: userImageURL!)!)
                    })
                }
            }
    }
    
    
    // MARK: - Memory Management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
