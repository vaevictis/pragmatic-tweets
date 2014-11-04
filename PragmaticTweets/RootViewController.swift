//
//  ViewController.swift
//  PragmaticTweets
//
//  Created by vaevictis on 28/10/2014.
//  Copyright (c) 2014 guillaume hammadi. All rights reserved.
//

import UIKit
import Social
import Accounts

public class RootViewController: UITableViewController, TwitterAPIRequestDelegate {
    
    var parsedTweets: Array <ParsedTweet> = [
        ParsedTweet(tweetText: "I want a kebab",
            userName: "@ghammadi",
            createdAt: "2014-29-10 10:10 EDT",
            userAvatarURL: NSURL(string:"https://pbs.twimg.com/profile_images/501964725341523968/rMhRqf4H_normal.jpeg")),
    ]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        var refresher = UIRefreshControl()
        refresher.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresher
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func reloadTweets() {
        let twitterParams : Dictionary = ["count" :"100", "screen_name": "JaydenJaymes", "include_rts": "1"]
        let twitterAPIURL = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json")
        let request = TwitterAPIRequest()
        request.sendTwitterRequest(twitterAPIURL, params: twitterParams, delegate: self)
        
    }
    
    func handleTwitterData (data: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!, fromRequest: TwitterAPIRequest!) {
        println(NSThread.isMainThread() ? "is main thread" : "is not main thread")
        if let dataValue = data {
            var parseError: NSError? = nil
            let jsonObject : AnyObject? = NSJSONSerialization.JSONObjectWithData(dataValue, options: NSJSONReadingOptions(0), error: &parseError)
            
            if parseError != nil { return }
            if let jsonArray = jsonObject as? Array<Dictionary<String, AnyObject>> {
                self.parsedTweets.removeAll(keepCapacity: true)
                var index: Int = 0
                
                for tweetDict in jsonArray {
                    let parsedTweet = ParsedTweet()
                    parsedTweet.tweetText = tweetDict["text"] as? NSString
                    parsedTweet.createdAt = tweetDict["created_at"] as? NSString
                    
                    let userDict = tweetDict["user"] as NSDictionary
                    
                    parsedTweet.userName  = userDict["name"] as? NSString
                    parsedTweet.userAvatarURL = NSURL(string: userDict["profile_image_url"] as NSString! )
                    
                    self.parsedTweets.append(parsedTweet)
                }

                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    self.tableView.reloadData()
                })
            }
            
        } else {
            println("HandleTwitterData: No data received")
        }
    }
    
    @IBAction func handleRefresh (sender: AnyObject?) {
//        self.parsedTweets.append(
//            ParsedTweet (
//                tweetText: "new row",
//                userName: "@refresh",
//                createdAt: NSDate().description,
//                userAvatarURL: defaultAvatarURL)
//        )
//        
        reloadTweets()
        refreshControl!.endRefreshing()
    }
    
    @IBAction func handleTweetButtonTapped(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
        
            let tweetVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            let message = NSBundle.mainBundle().localizedStringForKey("First tweet from some #swift code. Sweet. #pragsios8", value: "", table: nil)
            
            tweetVC.setInitialText(message)
            tweetVC.completionHandler = {
                (SLComposeViewControllerResult result) -> Void in
                if result == SLComposeViewControllerResult.Done {
                    self.reloadTweets()
                }
            }
            
            self.presentViewController(tweetVC, animated: true, completion: nil)
        } else {
            println("Can't send tweet")
        }
    }
    
    
    //    TableView Data source protocol implementation
    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
        
    override public func tableView(_tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.parsedTweets.count
    }
    
    override public func tableView(_tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomTweetCell") as ParsedTweetCell
        
        let parsedTweet = parsedTweets[indexPath.row]
        cell.tweetTextLabel.text = parsedTweet.tweetText
        cell.userNameLabel.text = parsedTweet.userName
        cell.createdAtLabel!.text = parsedTweet.createdAt
        
        if parsedTweet.userAvatarURL != nil {
            cell.avatarImageView.image = nil
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            () -> Void in
            let avatarImage = UIImage(data: NSData (contentsOfURL: parsedTweet.userAvatarURL!)!)
            dispatch_async(dispatch_get_main_queue(), {
                if cell.userNameLabel.text == parsedTweet.userName {
                    cell.avatarImageView.image = avatarImage
                } else {
                    println("oops, wrong cell, never mind!")
                }
            })
        })
        
        return cell
    }
    
}
