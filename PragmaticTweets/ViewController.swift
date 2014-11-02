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

public class ViewController: UITableViewController {
    
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
        let accountStore = ACAccountStore()
        let twitterAccountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        let twitterAccounts = accountStore.accountsWithAccountType(twitterAccountType)
        
        if twitterAccounts.count == 0 {
            println("no twitter account configured")
        } else {
            
        }
        
        accountStore.requestAccessToAccountsWithType(twitterAccountType,
            options: nil,
            completion: {
                (BOOL granted, NSError error) -> Void
            in
                if (!granted) {
                    println("account access not granted")
                } else {
                    let twitterParams = ["count" :100]
                    let twitterAPIURL = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json")
                    let request = SLRequest(
                        forServiceType: SLServiceTypeTwitter,
                        requestMethod: SLRequestMethod.GET,
                        URL: twitterAPIURL,
                        parameters: twitterParams
                    )
                    request.account = twitterAccounts[0] as ACAccount
                    request.performRequestWithHandler( {
                        (NSData data, NSHTTPURLResponse urlResponse,NSError error) -> Void in self.handleTwitterData(data, urlResponse: urlResponse, error: error)
                    })
                }
        })
    }
    
    func handleTwitterData (data: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!) {
        if let dataValue = data {
            var parseError: NSError? = nil
            let jsonObject : AnyObject? = NSJSONSerialization.JSONObjectWithData(dataValue, options: NSJSONReadingOptions(0), error: &parseError)
            println("JSON error: \(parseError)\nJSON response: \(jsonObject)")
        } else {
            println("HandleTwitterData: No data received")
        }
    }
    
    @IBAction func handleRefresh (sender: AnyObject?) {
        self.parsedTweets.append(
            ParsedTweet (
                tweetText: "new row",
                userName: "@refresh",
                createdAt: NSDate().description,
                userAvatarURL: defaultAvatarURL)
        )
        
        reloadTweets()
        refreshControl!.endRefreshing()
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
        
        cell.avatarImageView.image = UIImage (data: NSData (contentsOfURL: parsedTweet.userAvatarUrl!)!)
        
        
        return cell
    }
    
}
