//
//  BookingListTVCell.swift
//  HomeStay
//
//  Created by apple on 18/11/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BookingListTVCell: UITableViewCell {

    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var imgHeart: UIImageView!
    @IBOutlet weak var imgProperty: UIImageView!
    @IBOutlet weak var lblReqID: UILabel!
    @IBOutlet weak var lblPropertyName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblLoc: UILabel!
    @IBOutlet weak var lblBookingDate: UILabel!
    @IBOutlet weak var lblPickupDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOwnerName: UILabel!
    
    @IBOutlet weak var lblGuestCount: UILabel!
    @IBOutlet weak var lblDats: UILabel!
    @IBOutlet weak var lblDropDate: UILabel!
    
    @IBOutlet weak var btnWishlist: UIButton!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    
    @IBOutlet weak var bookingDateLbl: UILabel!
    @IBOutlet weak var pickUpLbl: UILabel!
    @IBOutlet weak var DropLbl: UILabel!
    @IBOutlet weak var totalAmtLbl: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewShadow.cornerRadius = 10
        viewShadow.layer.shadowColor = UIColor.lightGray.cgColor
        viewShadow.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewShadow.layer.shadowOpacity = 0.7
        viewShadow.layer.shadowRadius = 4.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
