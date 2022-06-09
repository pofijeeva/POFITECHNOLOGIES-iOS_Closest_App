//
//  NewCouponTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 18/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class NewCouponTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var PropertyNameLbl: UILabel!
    @IBOutlet weak var PropertyPerLbl: UILabel!
     @IBOutlet weak var offLbl: UILabel!
     @IBOutlet weak var CouponCodeLbl: UILabel!
     @IBOutlet weak var ExpiryLbl: UILabel!
     @IBOutlet weak var ExpiryDateLbl: UILabel!
     @IBOutlet weak var LimitLbl: UILabel!
     @IBOutlet weak var limitValLbl: UILabel!
    @IBOutlet weak var bgImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
