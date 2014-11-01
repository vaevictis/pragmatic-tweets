//
//  ParsedTweetCell.swift
//  PragmaticTweets
//
//  Created by vaevictis on 1/11/2014.
//  Copyright (c) 2014 guillaume hammadi. All rights reserved.
//

import UIKit

class ParsedTweetCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
