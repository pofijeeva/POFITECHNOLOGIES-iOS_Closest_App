//
//  hostPayOutCell.swift
//  HomeStay
//
//  Created by pofiapple10 on 23/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class hostPayOutCell: UITableViewCell {

    @IBOutlet weak var hostview: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var transactionIdlabel: UILabel!
    @IBOutlet weak var AmountLabel: UILabel!
    @IBOutlet weak var CurrencyLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hostview.layer.cornerRadius = 4
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
