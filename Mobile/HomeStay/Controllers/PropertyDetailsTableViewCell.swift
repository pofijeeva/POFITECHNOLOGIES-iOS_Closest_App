//
//  PropertyDetailsTableViewCell.swift
//  HomeStay
//
//  Created by Dinesh on 10/05/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class PropertyDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var detailsNameTxtLabel: UILabel!
    @IBOutlet weak var detailsValueTxtLabel: UILabel!
    @IBOutlet weak var detailsValueButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
