//
//  MessageSenderCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 04/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class MessageSenderCell: UITableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var imgSender: UIImageView!
    @IBOutlet weak var imgBubbleSender: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
