//
//  PaymentDetailsCell.swift
//  HomeStay
//
//  Created by pofiapple10 on 23/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class PaymentDetailsCell: UITableViewCell {

    @IBOutlet weak var pendingLbl: UILabel!
    
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var bookingNoLbl: UILabel!
    @IBOutlet weak var nameDesLbl: UILabel!
    @IBOutlet weak var transactionIdLbl: UILabel!
    @IBOutlet weak var transactiontypeLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    
    
    
    @IBOutlet weak var transId: UILabel!
    @IBOutlet weak var transType: UILabel!
    @IBOutlet weak var currencytype: UILabel!
    @IBOutlet weak var Amttype: UILabel!
    @IBOutlet weak var Statustype: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        paymentView.layer.cornerRadius = 10
        pendingLbl.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
