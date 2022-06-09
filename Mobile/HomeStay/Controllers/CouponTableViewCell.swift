//
//  CouponTableViewCell.swift
//  HomeStay
//
//  Created by Apple2 on 12/07/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CouponTableViewCell: UITableViewCell {

    
    @IBOutlet weak var couponName: UILabel!
    @IBOutlet weak var daysLbl: UILabel!
    @IBOutlet weak var couponTimeLimit: UILabel!
    @IBOutlet weak var couponCodeLbl: UILabel!
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var secLbl: UILabel!
    @IBOutlet weak var minLbl: UILabel!
    
     @IBOutlet weak var CouponAvaLbl: UILabel!
    
    @IBOutlet weak var hours: UILabel!
      @IBOutlet weak var sec: UILabel!
      @IBOutlet weak var min: UILabel!
     @IBOutlet weak var days: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
