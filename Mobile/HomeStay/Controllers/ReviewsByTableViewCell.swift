//
//  ReviewsByTableViewCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 30/10/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ReviewsByTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var img_User: UIImageView!
    @IBOutlet weak var lbl_username: UILabel!
    @IBOutlet weak var lbl_reviews: UILabel!
    @IBOutlet weak var hostName: UILabel!
    
    @IBOutlet weak var rentalName: UILabel!
    @IBOutlet weak var bookingIdLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var bookingDateLabel: UILabel!
    
    @IBOutlet weak var reviewsRatingView: FloatRatingView!
    @IBOutlet weak var rentalNameButton: UIButton!
    @IBOutlet weak var rentalBookingLbl: UILabel!
    
    
    ///////////// PROPERTY REVIEW MORE ////////////////
    
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var reviewDateLbl: UILabel!
    @IBOutlet weak var reviewCommentLbl: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
   
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
