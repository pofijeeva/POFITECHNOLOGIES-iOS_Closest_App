//
//  DetailPagePriceTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 13/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class DetailPagePriceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var PriceHeader: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var SecurityDepositLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
