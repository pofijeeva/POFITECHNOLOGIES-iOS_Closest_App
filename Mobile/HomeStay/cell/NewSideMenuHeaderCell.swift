//
//  NewSideMenuHeaderCell.swift
//  HomeStay
//
//  Created by CIFCL on 02/01/22.
//  Copyright © 2022 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class NewSideMenuHeaderCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
