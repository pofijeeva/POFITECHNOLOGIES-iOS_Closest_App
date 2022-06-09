//
//  ExperienceDetailImageTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 04/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceDetailImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var BaseView: UIView!
        @IBOutlet weak var ExperienceImg: UIImageView!
        @IBOutlet weak var ExperienceTitle: UILabel!
        @IBOutlet weak var ExperiencePrice: UILabel!
       @IBOutlet weak var ExperienceRating: UILabel!
     @IBOutlet weak var ExperienceLocation: UILabel!
     @IBOutlet weak var ExperienceViewed: UILabel!
    
        @IBOutlet weak var ExperienceHr: UILabel!
       
       @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var ShareBtn: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
