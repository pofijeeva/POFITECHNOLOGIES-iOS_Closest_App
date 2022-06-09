//
//  AmenitiesCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 03/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class AmenitiesCell: UITableViewCell {

    @IBOutlet weak var lblAmenities: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var PriceTxt: UITextField!
    @IBOutlet weak var PriceTxtHeight: NSLayoutConstraint!
    @IBOutlet weak var editBtn: UIButton!



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
