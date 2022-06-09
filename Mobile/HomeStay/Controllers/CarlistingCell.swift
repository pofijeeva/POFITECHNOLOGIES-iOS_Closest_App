//
//  CarlistingCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 21/12/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CarlistingCell: UITableViewCell {
    
    
    @IBOutlet weak var img_listicon: UIImageView!
    
    @IBOutlet weak var lbl_listname: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
