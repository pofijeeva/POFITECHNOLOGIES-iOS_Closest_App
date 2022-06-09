//
//  InvoiceLastTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 29/04/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class InvoiceLastTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var PaymentDetailsLbl: UILabel!
    @IBOutlet weak var BookedDaysLbl: UILabel!
    @IBOutlet weak var BookedDaysLblValueLbl: UILabel!
    @IBOutlet weak var SecurityDepositLbl: UILabel!
    @IBOutlet weak var SecurityDepositValueLbl: UILabel!
    
    @IBOutlet weak var ServiceFeeLbl: UILabel!
    @IBOutlet weak var ServiceFeeValueLbl: UILabel!
    
    @IBOutlet weak var CouponView: UIView!
    @IBOutlet weak var CouponLbl: UILabel!
    @IBOutlet weak var CouponValueLbl: UILabel!
    @IBOutlet weak var CouponHeight: NSLayoutConstraint!
    
    @IBOutlet weak var WalletView: UIView!
    @IBOutlet weak var WalletLbl: UILabel!
    @IBOutlet weak var WalletValueLbl: UILabel!
    @IBOutlet weak var WalletHeight: NSLayoutConstraint!
    
    @IBOutlet weak var Addonsiew: UIView!
    @IBOutlet weak var AddonsLbl: UILabel!
    @IBOutlet weak var AddonsValueLbl: UILabel!
    @IBOutlet weak var AddonsHeight: NSLayoutConstraint!

    @IBOutlet weak var BundleView: UIView!
    @IBOutlet weak var BundleLbl: UILabel!
    @IBOutlet weak var BundleValueLbl: UILabel!
    @IBOutlet weak var BundleHeight: NSLayoutConstraint!

    @IBOutlet weak var TotalLbl: UILabel!
    @IBOutlet weak var TotalValueLbl: UILabel!
    @IBOutlet weak var PaidLbl: UILabel!
    @IBOutlet weak var PaidValueLbl: UILabel!
    
    @IBOutlet weak var PayLater: UIView!
    @IBOutlet weak var PayLaterLbl: UILabel!
    @IBOutlet weak var PayLaterValueLbl: UILabel!
    @IBOutlet weak var PayLaterHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.PaymentDetailsLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.BookedDaysLbl.font = UIFont(name: RegularFont, size: 14)
        self.PayLaterLbl.font = UIFont(name: RegularFont, size: 14)

        self.BookedDaysLblValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.SecurityDepositLbl.font = UIFont(name: RegularFont, size: 14)
        self.SecurityDepositValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.ServiceFeeLbl.font = UIFont(name: RegularFont, size: 14)
        self.ServiceFeeValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.CouponLbl.font = UIFont(name: RegularFont, size: 14)
        self.CouponValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.WalletLbl.font = UIFont(name: RegularFont, size: 14)
        self.WalletValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.PayLaterValueLbl.font = UIFont(name: SemiBoldFont, size: 14)

        self.AddonsLbl.font = UIFont(name: RegularFont, size: 14)
        self.AddonsValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.BundleLbl.font = UIFont(name: RegularFont, size: 14)
        self.BundleValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        
        self.TotalLbl.font = UIFont(name: RegularFont, size: 14)
        self.TotalValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.PaidLbl.font = UIFont(name: RegularFont, size: 14)
        self.PaidValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
