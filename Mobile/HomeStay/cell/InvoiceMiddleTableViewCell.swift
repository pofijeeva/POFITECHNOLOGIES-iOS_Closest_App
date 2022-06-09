//
//  InvoiceMiddleTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 30/04/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class InvoiceMiddleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var BundleLbl: UILabel!
    @IBOutlet weak var BundleValueLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.BundleValueLbl.textAlignment = .right
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
