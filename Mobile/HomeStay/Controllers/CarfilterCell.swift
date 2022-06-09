//
//  CarfilterCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 14/12/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CarfilterCell: UITableViewCell {
    
    @IBOutlet weak var lbl_Name: UILabel!
    
    @IBOutlet weak var btn_Check: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
