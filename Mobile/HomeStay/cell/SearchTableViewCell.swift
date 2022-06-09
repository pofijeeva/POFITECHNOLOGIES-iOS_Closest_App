//
//  SearchTableViewCell.swift
//  HomeStay
//
//  Created by saravanan2 on 26/12/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var LocationName: UILabel!
    @IBOutlet weak var locationIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
