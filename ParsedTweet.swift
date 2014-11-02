//
//  ParsedTweet.swift
//  PragmaticTweets
//
//  Created by vaevictis on 1/11/2014.
//  Copyright (c) 2014 guillaume hammadi. All rights reserved.
//

import UIKit

let defaultAvatarURL = NSURL(string: "http://pbs.twimg.com/profile_images/2284174872/7df3h38zabcvjylnyfe3_bigger.png")

class ParsedTweet: NSObject {
    var tweetText: String?
    var userName:  String?
    var createdAt: String?
    var userAvatarURL: NSURL?
    
    init(tweetText: String?, userName: String?, createdAt: String?, userAvatarURL: NSURL?) {
        super.init()
        
        self.tweetText = tweetText
        self.userName = userName
        self.createdAt = createdAt
        self.userAvatarURL = userAvatarURL
    }

    init(tweetText: String?, userName: String?, createdAt: String?) {
        self.tweetText = tweetText
        self.userName = userName
        self.createdAt = createdAt
        self.userAvatarURL = defaultAvatarURL
    }
    
    override init() {
        super.init()
    }
}
