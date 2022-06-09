//
//  ReqBookPriceTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 30/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ReqBookPriceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
     
       @IBOutlet weak var BookingLbl: UILabel!
         @IBOutlet weak var ServiceFeeLbl: UILabel!
       @IBOutlet weak var SecurityDepositLbl: UILabel!
    @IBOutlet weak var BookingValueLbl: UILabel!
          @IBOutlet weak var ServiceFeeValueLbl: UILabel!
        @IBOutlet weak var SecurityDepositValueLbl: UILabel!
       
    @IBOutlet weak var TotalLbl: UILabel!
        @IBOutlet weak var TotalValueLbl: UILabel!
    @IBOutlet weak var TotalView: UIView!

    @IBOutlet weak var addonsView: UIView!
    @IBOutlet weak var addonsLbl: UILabel!
    @IBOutlet weak var addonsValueLbl: UILabel!
    @IBOutlet weak var addonsViewHeight: NSLayoutConstraint!

    
    @IBOutlet weak var bundleView: UIView!
    @IBOutlet weak var bundleLbl: UILabel!
    @IBOutlet weak var bundleValueLbl: UILabel!
    @IBOutlet weak var BundleViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var payLaterView: UIView!
    @IBOutlet weak var payLaterLbl: UILabel!
    @IBOutlet weak var payLaterValueLbl: UILabel!
    @IBOutlet weak var payLaterViewHeight: NSLayoutConstraint!

    
    @IBOutlet weak var PayBalanceView: UIView!
    @IBOutlet weak var PayBalanceLbl: UILabel!
    @IBOutlet weak var PayBalanceValueLbl: UILabel!
    @IBOutlet weak var PayBalanceViewHeight: NSLayoutConstraint!

    @IBOutlet weak var infoBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
