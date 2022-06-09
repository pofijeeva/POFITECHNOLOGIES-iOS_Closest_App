//
//  ExperienceReservationTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 09/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceReservationTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var ExpImg: UIImageView!
    @IBOutlet weak var ExpNameLbl: UILabel!
    @IBOutlet weak var ExpDateLbl: UILabel!
    @IBOutlet weak var ExpaddressLbl: UILabel!
    @IBOutlet weak var ExppayStatusLbl: UILabel!
    @IBOutlet weak var ExpPayStatusValueLbl: UILabel!
    @IBOutlet weak var ExpHostAppLbl: UILabel!
    @IBOutlet weak var ExpHostAppValueLbl: UILabel!
    @IBOutlet weak var ExpBookingIdLbl: UILabel!
    @IBOutlet weak var ExpBookingIDValueLbl: UILabel!
    @IBOutlet weak var ExpHostNameLbl: UILabel!
    @IBOutlet weak var ExpPriceLbl: UILabel!
    
    @IBOutlet weak var ThreeDots: UIButton!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
