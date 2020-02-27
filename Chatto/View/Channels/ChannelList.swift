//
//  MessageListCell.swift
//  Chatto
//
//  Created by User on 2/17/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import UIKit

class ChannelList: UITableViewCell {
    @IBOutlet  weak var lblUsername :UILabel!
    @IBOutlet  weak var lblMessage :UILabel!
    @IBOutlet  weak var imgUser :UIImageView!
    @IBOutlet  weak var lblActiveAgo :UILabel!
    @IBOutlet  weak var lblUnseenMessagesNo :UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgUser.setCircleImg()
        lblUnseenMessagesNo.setCircleImg()
    }
    public var cellChannel: Channel? {
        didSet {
//            let dateString = cellNotification?.insertDate
//            let convertedDate = dateString?.getDate()
//            let timeAgo = convertedDate?.timeAgoSinceDate()
//            self.lblTime.text = timeAgo
            
            self.lblUsername.text = cellChannel?.displayName
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
