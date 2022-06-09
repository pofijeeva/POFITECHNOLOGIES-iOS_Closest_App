//
//  InvoiceFirstTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 29/04/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class InvoiceFirstTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var BookingNumLbl: UILabel!
    @IBOutlet weak var RentalNameLbl: UILabel!
    @IBOutlet weak var RemntalNameValueLbl: UILabel!
    @IBOutlet weak var RentalAddressLbl: UILabel!
    @IBOutlet weak var RemntalAddressValueLbl: UILabel!
    
    @IBOutlet weak var DurationLbl: UILabel!
    @IBOutlet weak var DurationValueLbl: UILabel!
    @IBOutlet weak var GuestLbl: UILabel!
    @IBOutlet weak var GuestValueLbl: UILabel!
    @IBOutlet weak var DaysHoursLbl: UILabel!
    @IBOutlet weak var DaysHoursValueLbl: UILabel!
    @IBOutlet weak var CancellationPolicyLbl: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        self.BookingNumLbl.font = UIFont(name: RegularFont, size: 14)
        self.RentalNameLbl.font = UIFont(name: RegularFont, size: 14)
        self.RemntalNameValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.RentalAddressLbl.font = UIFont(name: RegularFont, size: 14)
        self.RemntalAddressValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.DurationLbl.font = UIFont(name: RegularFont, size: 14)
        self.DurationValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.GuestLbl.font = UIFont(name: RegularFont, size: 14)
        self.GuestValueLbl.font = UIFont(name: SemiBoldFont, size: 14)

        self.DaysHoursLbl.font = UIFont(name: RegularFont, size: 14)
        self.DaysHoursValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.CancellationPolicyLbl.font = UIFont(name: RegularFont, size: 14)
        
        self.DurationValueLbl.textColor = AppColor
        self.GuestValueLbl.textColor = AppColor
        self.DaysHoursValueLbl.textColor = AppColor

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
