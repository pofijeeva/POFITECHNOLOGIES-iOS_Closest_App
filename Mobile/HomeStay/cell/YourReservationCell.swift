//
//  YourReservationCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 21/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class YourReservationCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblHostApproval: UILabel!
    @IBOutlet weak var lblPropertyTitle: UILabel!
    @IBOutlet weak var lblBookingdate: UILabel!
    @IBOutlet weak var lblPaymentStatus: UILabel!
    @IBOutlet weak var lblBookingNumber: UILabel!
    @IBOutlet weak var lblPropertyLocation: UILabel!
    @IBOutlet weak var dotsButton: UIButton!
    @IBOutlet weak var couponAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
