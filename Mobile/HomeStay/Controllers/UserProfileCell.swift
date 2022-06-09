//
//  UserProfileCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 07/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class UserProfileCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var lblName: UILabel!
     @IBOutlet weak var countLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
