//
//  InboxTVCell.swift
//  HomeStay
//
//  Created by apple on 20/11/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class InboxTVCell: UITableViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgprofile: UIImageView!
    @IBOutlet weak var lblName_ID: UILabel!
    @IBOutlet weak var lblBookType: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnDelete: UIButton?
    @IBOutlet weak var trashImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
