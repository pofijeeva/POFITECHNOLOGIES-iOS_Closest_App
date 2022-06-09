//
//  CountrylistTableViewCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 10/10/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CountrylistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_CountryName: UILabel!
    @IBOutlet weak var buttonSelect: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
