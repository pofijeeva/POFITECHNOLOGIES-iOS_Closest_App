//
//  CarAmenitiesTableViewCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 29/11/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CarAmenitiesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img_Amenities: UIImageView!
    
    @IBOutlet weak var lbl_AmenityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
