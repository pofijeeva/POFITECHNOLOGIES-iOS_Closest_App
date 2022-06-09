//
//  MyReviewTVCell.swift
//  HomeStay
//
//  Created by apple on 22/11/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Cosmos
class MyReviewTVCell: UITableViewCell {

    @IBOutlet weak var hostAmountLbl: UILabel!
    @IBOutlet weak var refundAmountLbl: UILabel!
    @IBOutlet weak var cancelPerCentLbl: UILabel!
    @IBOutlet weak var totalBookingAmountLbl: UILabel!
    @IBOutlet weak var cancelByGuestLbl: UILabel!
    @IBOutlet weak var thirdDescriptionLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet var viewContent: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet var lblName_Date: UILabel!
    @IBOutlet var lblreview_rating: UIView!
    
    
    @IBOutlet weak var ratingView: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContent.layer.shadowColor =
            UIColor.black.cgColor
        viewContent.layer.cornerRadius = 5
        viewContent.layer.shadowOffset = CGSize.zero
        viewContent.layer.shadowOpacity = 0.6
//        cancelByGuestLbl.layer.borderWidth  = 3
//        cancelByGuestLbl.layer.cornerRadius = 5
//        cancelByGuestLbl.layer.borderColor = UIColor.orange.cgColor
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
