//
//  VehicleTripsTableViewCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 08/12/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class VehicleTripsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var img_Trip: UIImageView!
    @IBOutlet weak var lbl_CarName: UILabel!
    @IBOutlet weak var lbl_HostedBy: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_BookingNum: UILabel!
    @IBOutlet weak var lbl_PaymentStatus: UILabel!
    @IBOutlet weak var lbl_HostapprovalStatus: UILabel!
    @IBOutlet weak var lbl_tripAmt: UILabel!
    @IBOutlet weak var btn_MoreOptions: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
