//
//  PropertyDescriptionTableViewCell.swift
//  HomeStay
//
//  Created by Dinesh on 10/05/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class PropertyDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var propertyDesc_Lbl: UILabel!
     @IBOutlet weak var Desc_Lbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
