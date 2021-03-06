//
//  ChatReceiveTableViewCell.swift
//  ChatApp
//
//  Created by Jorge Lapeña Antón on 16/04/2019.
//  Copyright © 2019 Jorge Lapeña Antón. All rights reserved.
//

import UIKit
import MaterialComponents

class ChatReceiveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelHour: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var viewText: MDCCard!
    @IBOutlet weak var separationLabel: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        viewText.isInteractable = false
        viewText.setShadowElevation(.cardResting, for: .normal)
        viewText.setShadowColor(.black, for: .normal)
        viewText.cornerRadius = 5
        viewText.translatesAutoresizingMaskIntoConstraints = false
    }
    public var msgCell: Message? {
        didSet {
            self.descriptionLabel.text = msgCell?.msg
            self.labelHour.text = msgCell?.timeStamp
        }
    }
}
