//
//  TransactionHistoryCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 20/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class TransactionHistoryCell: UITableViewCell {

    //MARK:- Outlets
    
    @IBOutlet weak var lblDateID: UILabel!
    @IBOutlet weak var lblPropertyName: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnTotal: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTotalValue: UILabel!
    @IBOutlet weak var lblServiceFee: UILabel!
    @IBOutlet weak var lblHostFee: UILabel!
    @IBOutlet weak var lblNetAmount: UILabel!
    @IBOutlet weak var lblHostFeeAmount: UILabel!
    @IBOutlet weak var lblNetAmountAmount: UILabel!
    @IBOutlet weak var imgDropDown: UIImageView!
    @IBOutlet weak var viewDropdown: UIView!
    
    @IBOutlet weak var lbl_ServicefeeAmount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
