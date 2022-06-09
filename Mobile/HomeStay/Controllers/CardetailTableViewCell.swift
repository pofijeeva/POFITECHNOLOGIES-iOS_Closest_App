//
//  CardetailTableViewCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 29/11/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CardetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_AmenitiesName: UILabel!
 
    @IBOutlet weak var lbl_AmenitiesValue: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
