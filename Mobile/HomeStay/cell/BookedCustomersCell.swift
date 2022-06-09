//
//  BookedCustomersCell.swift
//  HomeStay
//
//  Created by pofiapple10 on 22/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BookedCustomersCell: UITableViewCell {

    @IBOutlet weak var bookingaNOlBL: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var locNameLbl: UILabel!
    @IBOutlet weak var checkInLbl: UILabel!
    @IBOutlet weak var checkOutLbl: UILabel!
    @IBOutlet weak var bookingStatusLbl: UILabel!
    @IBOutlet weak var transactiontypeLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var hostApprovallbl: UILabel!
    @IBOutlet weak var hostApprovalLbl: UILabel!
    
    @IBOutlet weak var approveBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bookingStatusLbl.layer.cornerRadius = 6
        hostApprovallbl.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
