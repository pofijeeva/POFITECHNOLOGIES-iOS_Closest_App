//
//  ExperienceNowTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 03/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceNowTableViewCell: UITableViewCell {

     @IBOutlet weak var BaseView: UIView!
     @IBOutlet weak var ExperienceImg: UIImageView!
     @IBOutlet weak var ExperienceTitle: UILabel!
     @IBOutlet weak var ExperiencePrice: UILabel!
    @IBOutlet weak var ExperienceRating: UILabel!
     @IBOutlet weak var ExperienceRatingView: UIView!
    
    @IBOutlet weak var FavBtn: UIButton!
     @IBOutlet weak var FavImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
