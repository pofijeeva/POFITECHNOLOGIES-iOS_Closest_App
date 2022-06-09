//
//  PayoutMethodCell.swift
//  HomeStay
//
//  Created by pofiapple10 on 24/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class PayoutMethodCell: UITableViewCell {

    @IBOutlet weak var txtBankName: UITextField!
    @IBOutlet weak var txtBranchName: UITextField!
    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var txtIfscCode: UITextField!
    @IBOutlet weak var Submitbtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        Submitbtn.layer.cornerRadius = 10
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
