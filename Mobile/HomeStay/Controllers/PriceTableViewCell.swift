//
//  PriceTableViewCell.swift
//  HomeStay
//
//  Created by dineshkumarr on 02/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {

    @IBOutlet weak var labelUnitPrice: UILabel!
    @IBOutlet weak var labelUnitPriceValue: UILabel!
    @IBOutlet weak var labelServiceFee: UILabel!
    @IBOutlet weak var labelServiceFeeValue: UILabel!
    @IBOutlet weak var labelSecurityDeposit: UILabel!
    @IBOutlet weak var labelValueSecurityDeposit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelUnitPrice.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelUnitPrice.textColor = UIColor.darkGray
        self.labelUnitPriceValue.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelUnitPriceValue.textColor = UIColor.darkGray
        self.labelServiceFee.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelServiceFee.textColor = UIColor.darkGray
        self.labelServiceFeeValue.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelServiceFeeValue.textColor = UIColor.darkGray
        self.labelSecurityDeposit.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelSecurityDeposit.textColor = UIColor.darkGray
        self.labelValueSecurityDeposit.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelValueSecurityDeposit.textColor = UIColor.darkGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
