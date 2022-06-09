//
//  InboxCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 04/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class InboxCell: UITableViewCell {

    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblBooking: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var UnreadMsgCount: UILabel!

    
    @IBOutlet weak var starredBtn: UIButton!
    @IBOutlet weak var archiveBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
