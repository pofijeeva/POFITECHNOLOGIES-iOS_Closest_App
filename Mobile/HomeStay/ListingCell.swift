//
//  ListingCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 02/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ListingCell: UITableViewCell {

   @IBOutlet weak var lblName: UILabel!
   @IBOutlet weak var imgIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
