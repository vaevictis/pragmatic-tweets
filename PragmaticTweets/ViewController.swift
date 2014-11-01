//
//  ViewController.swift
//  PragmaticTweets
//
//  Created by vaevictis on 28/10/2014.
//  Copyright (c) 2014 guillaume hammadi. All rights reserved.
//

import UIKit
import Social

public class ViewController: UITableViewController {
    
    var parsedTweets: Array <ParsedTweet> = [
        ParsedTweet(tweetText:"iOS SDK Development now in print. " + "Swift programming FTW!!!",
            userName: "@ghammadi",
            createdAt: "2014-01-11 12:50 EDT"),
        
        ParsedTweet(tweetText: "Math is cool",
            userName: "@redqueencoder",
            createdAt: "2014-29-10 10:10 EDT"),
        
        ParsedTweet(tweetText: "I want a kebab",
            userName: "@ghammadi",
            createdAt: "2014-29-10 10:10 EDT",
            userAvatarURL: NSURL(string:"https://pbs.twimg.com/profile_images/501964725341523968/rMhRqf4H_normal.jpeg"))

    ]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadTweets()
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func reloadTweets() {
        self.tableView.reloadData()
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
