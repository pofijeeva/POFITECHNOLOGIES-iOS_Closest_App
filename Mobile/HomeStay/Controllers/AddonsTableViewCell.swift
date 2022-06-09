//
//  AddonsTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 26/04/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class AddonsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var AddonsImg: UIImageView!
    @IBOutlet weak var AddonsLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
