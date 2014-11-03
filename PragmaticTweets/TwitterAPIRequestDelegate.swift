//
//  TwitterAPIRequestDelegate.swift
//  PragmaticTweets
//
//  Created by vaevictis on 3/11/2014.
//  Copyright (c) 2014 guillaume hammadi. All rights reserved.
//

import Foundation

protocol TwitterAPIRequestDelegate {
    func handleTwitterData (data: NSData!,
        urlResponse: NSHTTPURLResponse!,
        error: NSError!,
        fromRequest: TwitterAPIRequest!)
}