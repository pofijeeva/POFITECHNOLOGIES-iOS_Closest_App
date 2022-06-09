//
//  MenudetailTableViewCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 15/10/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class MenudetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgview_menu: UIImageView!
    @IBOutlet weak var lbl_Menu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
