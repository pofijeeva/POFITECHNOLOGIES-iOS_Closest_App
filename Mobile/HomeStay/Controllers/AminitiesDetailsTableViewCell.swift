//
//  AminitiesDetailsTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 08/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class AminitiesDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var AminitiesImg : UIImageView!
    @IBOutlet weak var BaseView : UIView!
    @IBOutlet weak var AminitiesNameLbl : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
