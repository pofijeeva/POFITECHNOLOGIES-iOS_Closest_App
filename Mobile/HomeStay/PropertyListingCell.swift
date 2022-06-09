//
//  PropertyListingCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 17/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class PropertyListingCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var img_Profile: UIImageView!
    @IBOutlet weak var lbl_PayOrManage: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var lbl_Status: UILabel!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var bookingLabel: UILabel!
    @IBOutlet weak var lbl_TotalBooking: UILabel!
    @IBOutlet weak var cancelLabel: UILabel!
    @IBOutlet weak var lbl_Cancellation: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var lbl_Rating: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var lbl_ReviewCount: UILabel!
    @IBOutlet weak var lbl_StepsToComplete: UILabel!
    @IBOutlet weak var lbl_statusfield: UILabel!
//    @IBOutlet weak var lbl_statusfield: UILabel!
    

    @IBOutlet weak var ManageLsitBtn: UIButton!

    @IBOutlet weak var HostBtn: UIButton!

    @IBOutlet weak var EmailIdVerifyBtn: UIButton!

    
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
