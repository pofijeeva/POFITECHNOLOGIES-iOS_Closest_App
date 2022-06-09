//
//  ManageCurrencyTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 18/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ManageCurrencyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
      @IBOutlet weak var CurrencySymbol: UILabel!
     @IBOutlet weak var CurrencyCode: UILabel!
     @IBOutlet weak var CurrencyBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
