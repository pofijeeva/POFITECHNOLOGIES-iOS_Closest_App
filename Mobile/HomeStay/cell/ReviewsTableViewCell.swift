//
//  ReviewsTableViewCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 30/10/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var img_user: UIImageView!
    @IBOutlet weak var lbl_reviewComments: UILabel!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var bookingIdLabel: UILabel!
    @IBOutlet weak var bookingDateLabel: UILabel!
    @IBOutlet weak var rentalName: UILabel!
    
    @IBOutlet weak var reviewRatings: FloatRatingView!
    @IBOutlet weak var rentalNameButton: UIButton!
    @IBOutlet weak var reviewBookNoLbl: UILabel!
    
    
    
    
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var AcceptRejectStatus: UILabel!
    
    /////////host cancellation////////////////
    
    
    @IBOutlet weak var bookingDateLbl: UILabel!
    @IBOutlet weak var bookingNumLbl: UILabel!
    @IBOutlet weak var rentNameLbl: UILabel!
    @IBOutlet weak var bookingDateTimeLbl: UILabel!
    @IBOutlet weak var cancelAmountLbl: UILabel!
    @IBOutlet weak var paidLbl: UILabel!
    @IBOutlet weak var balenceLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var shadowView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
