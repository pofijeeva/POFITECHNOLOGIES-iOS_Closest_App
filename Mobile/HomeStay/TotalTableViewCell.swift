//
//  TotalTableViewCell.swift
//  HomeStay
//
//  Created by dineshkumarr on 02/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class TotalTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var labelTotalValue: UILabel!
    @IBOutlet weak var buttonBookNow: UIButton!
    @IBOutlet weak var cancelLbl: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelTotal.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelTotal.textColor = UIColor.darkGray
        self.labelTotalValue.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelTotalValue.textColor = UIColor.darkGray
        self.buttonBookNow.titleLabel?.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.buttonBookNow.setTitleColor(UIColor.white, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
