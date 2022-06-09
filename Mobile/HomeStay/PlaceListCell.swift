//
//  PlaceListCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 27/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class PlaceListCell: UITableViewCell {

    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var imgPlace: UIImageView!
    @IBOutlet weak var btnLikeUnlike: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var img_Host: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
