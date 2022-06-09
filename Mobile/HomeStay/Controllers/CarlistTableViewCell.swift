//
//  CarlistTableViewCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 28/11/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CarlistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imag_Car: UIImageView!
    @IBOutlet weak var img_carHost: UIImageView!
    @IBOutlet weak var lbl_Car: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var btn_Fav: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
