//
//  MessageReceiverCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 04/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class MessageReceiverCell: UITableViewCell {

    @IBOutlet weak var imgReceiver: UIImageView!
    @IBOutlet weak var imgBubbleReceiver: UIImageView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
