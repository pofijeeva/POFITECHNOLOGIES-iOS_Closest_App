//
//  MenuCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 23/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    //MARK:- Outlets
    
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblMenu: UILabel!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var menuLeadingConstant: NSLayoutConstraint!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
