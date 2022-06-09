//
//  ChooseTimeTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 05/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ChooseTimeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var TimeLbl: UILabel!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var ChooseBtn: UIButton!
    @IBOutlet weak var BaseView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
