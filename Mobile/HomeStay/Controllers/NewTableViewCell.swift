//
//  NewTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 19/01/22.
//  Copyright © 2022 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell {

    @IBOutlet weak var bookingaNOlBL: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var locNameLbl: UILabel!
    @IBOutlet weak var checkInLbl: UILabel!
    @IBOutlet weak var checkOutLbl: UILabel!
    @IBOutlet weak var bookingStatusLbl: UILabel!
    @IBOutlet weak var transactiontypeLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var hostApprovallbl: UILabel!
    @IBOutlet weak var hostApprovalStatusLbl: UILabel!
    @IBOutlet weak var AddonsLbl: UILabel!
    @IBOutlet weak var AddonsLblHeight: NSLayoutConstraint!
    
    @IBOutlet weak var CheckIn: UILabel!
    @IBOutlet weak var CheckOut: UILabel!
    @IBOutlet weak var BookingStatus: UILabel!
    @IBOutlet weak var Amount: UILabel!
    @IBOutlet weak var Transactiontype: UILabel!
    @IBOutlet weak var bokkingno: UILabel!
    @IBOutlet weak var QtyLbl: UILabel!
    @IBOutlet weak var QtyImg: UIImageView!


    @IBOutlet weak var AddonsBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.CheckIn.font = UIFont(name: SemiBoldFont, size: 10)
        self.CheckOut.font = UIFont(name: SemiBoldFont, size: 10)
        self.BookingStatus.font = UIFont(name: SemiBoldFont, size: 15)
        self.Amount.font = UIFont(name: SemiBoldFont, size: 17)
        self.Transactiontype.font = UIFont(name: SemiBoldFont, size: 15)
        self.bokkingno.font = UIFont(name: SemiBoldFont, size: 17)

        self.bookingaNOlBL.font = UIFont(name: SemiBoldFont, size: 15)
        self.nameLbl.font = UIFont(name: SemiBoldFont, size: 17)

        self.locNameLbl.font = UIFont(name: SemiBoldFont, size: 12)
        self.checkInLbl.font = UIFont(name: SemiBoldFont, size: 10)
        self.checkOutLbl.font = UIFont(name: SemiBoldFont, size: 10)
        self.bookingStatusLbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.transactiontypeLbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.amountLbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.hostApprovallbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.hostApprovalStatusLbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.AddonsLbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.AddonsBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 15)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
