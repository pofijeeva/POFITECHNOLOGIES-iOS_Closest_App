//
//  TransactionCompleteTableViewCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 05/10/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class TransactionCompleteTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbl_TransactionMethodname: UILabel!
    
    
    @IBOutlet weak var lbl_TransactionAmount: UILabel!
    
    @IBOutlet weak var lbl_TransactionId: UILabel!
    
     @IBOutlet weak var TransactionMethodname: UILabel!
     @IBOutlet weak var TransactionId: UILabel!
    @IBOutlet weak var Amount: UILabel!
    
     @IBOutlet weak var BookingDateLbl: UILabel!
     @IBOutlet weak var BookingId: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
