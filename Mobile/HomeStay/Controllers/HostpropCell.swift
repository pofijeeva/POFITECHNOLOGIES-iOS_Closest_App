//
//  HostpropCell.swift
//  HomeStay Travel and Tours
//
//  Created by POFI TECHNOLOGIES on 30/01/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class HostpropCell: UITableViewCell
{
    
    @IBOutlet weak var img_Property: UIImageView!
    
    @IBOutlet weak var lbl_PropName: UILabel!
    
    
    @IBOutlet weak var lbl_LocationProp: UILabel!
    
    override func awakeFromNib() {
    super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
