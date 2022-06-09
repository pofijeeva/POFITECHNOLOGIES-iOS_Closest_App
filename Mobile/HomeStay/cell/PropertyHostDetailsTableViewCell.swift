//
//  PropertyHostDetailsTableViewCell.swift
//  HomeStay
//
//  Created by Dinesh on 10/05/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class PropertyHostDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var viewAllAmentiesBtn: UIButton!
    @IBOutlet weak var MoreAboutHostBtn: UIButton!
    @IBOutlet weak var hostImageView: UIImageView!
     @IBOutlet weak var AminitiesLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
