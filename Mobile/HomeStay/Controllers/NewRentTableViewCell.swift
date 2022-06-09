//
//  NewRentTableViewCell.swift
//  HomeStay
//
//  Created by Apple2 on 29/06/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class NewRentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rentImg: UIImageView!
    
    
    @IBOutlet weak var rentLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
