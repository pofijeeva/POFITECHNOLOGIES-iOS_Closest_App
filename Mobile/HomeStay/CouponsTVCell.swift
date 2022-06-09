//
//  CouponsTVCell.swift
//  HomeStay
//
//  Created by apple on 17/11/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CouponsTVCell: UITableViewCell {
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var lblCodeTitle: UILabel!
    @IBOutlet weak var lblCarName: UILabel!
    @IBOutlet weak var lblValidDate: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
