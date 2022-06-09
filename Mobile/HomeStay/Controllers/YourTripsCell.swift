//
//  YourTripsCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 03/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class YourTripsCell: UITableViewCell {

    
    //MARK:- Outlets
    
    @IBOutlet weak var imgTrip: UIImageView!
    @IBOutlet weak var lblTripAmount: UILabel!
    @IBOutlet weak var lblTripName: UILabel!
    @IBOutlet weak var lblTripHostedBy: UILabel!
    @IBOutlet weak var lblTripBookingNo: UILabel!
    @IBOutlet weak var lblTripDate: UILabel!
    @IBOutlet weak var lblTripPaymentStatus: UILabel!
    @IBOutlet weak var lblTripHostApproved: UILabel!
    @IBOutlet weak var btn_moreOptions: UIButton!
    @IBOutlet weak var lblTripPropertyName: UILabel!
    @IBOutlet weak var CouponLbl: UILabel!
    @IBOutlet weak var CouponLblHeight: NSLayoutConstraint!

    
    @IBOutlet weak var PayBalance: UIView!
    @IBOutlet weak var BalanceLbl: UILabel!
    @IBOutlet weak var PayBalanceBtn: UIButton!
    @IBOutlet weak var PayBalanceHeight: NSLayoutConstraint!
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var btn_Message: UIButton!
    @IBOutlet weak var btn_Review: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
