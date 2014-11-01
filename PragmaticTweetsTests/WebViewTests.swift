//
//  WebViewTests.swift
//  PragmaticTweets
//
//  Created by vaevictis on 31/10/2014.
//  Copyright (c) 2014 guillaume hammadi. All rights reserved.
//

import UIKit
import XCTest
import PragmaticTweets

class WebViewTests: XCTestCase, UIWebViewDelegate {

    var loadedWebViewExpectation : XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
