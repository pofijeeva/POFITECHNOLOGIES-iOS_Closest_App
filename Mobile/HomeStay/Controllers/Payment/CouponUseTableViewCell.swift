//
//  CouponUseTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 12/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CouponUseTableViewCell: UITableViewCell {

    
    
     @IBOutlet weak var BaseView: UIView!
     @IBOutlet weak var CouponTxt: UITextField!
     @IBOutlet weak var NoteLbl: UILabel!
    
     @IBOutlet weak var ApplyBtn: UIButton!
     @IBOutlet weak var CancelBtn: UIButton!
    
    @IBOutlet weak var AppliedView: UIView!
    @IBOutlet weak var TotalAmountLbl: UILabel!
    @IBOutlet weak var TotalAmountValueLbl: UILabel!
    @IBOutlet weak var AmountDiscountLbl: UILabel!
    @IBOutlet weak var AmountDiscountValueLbl: UILabel!

    @IBOutlet weak var AmounttobePaidLbl: UILabel!
    @IBOutlet weak var AmounttobePaidValueLbl: UILabel!
    @IBOutlet weak var AppliedViewHeight: NSLayoutConstraint!

    
     
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
