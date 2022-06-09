//
//  WalletUsedTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 12/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class WalletUsedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
        @IBOutlet weak var WalletLbl: UILabel!
     @IBOutlet weak var CheckBtn: UIButton!
        @IBOutlet weak var NoteLbl: UILabel!
       
        @IBOutlet weak var ApplyBtn: UIButton!
        @IBOutlet weak var CancelBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
