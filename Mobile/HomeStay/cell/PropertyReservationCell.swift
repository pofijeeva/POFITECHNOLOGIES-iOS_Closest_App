//
//  PropertyReservationCell.swift
//  HomeStay
//
//  Created by pofiapple10 on 18/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class PropertyReservationCell: UITableViewCell {
    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var proratingLabel: UILabel!
    @IBOutlet weak var pronameLabel: UILabel!
    @IBOutlet weak var prolocnameLabel: UILabel!
    @IBOutlet weak var prototalBookingLabel: UILabel!
    @IBOutlet weak var procancelBookingLabel: UILabel!
    @IBOutlet weak var proLocImg: UIImageView!
    @IBOutlet weak var totalBookingLbl: UILabel!
    @IBOutlet weak var cancelledBookingLbl: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
