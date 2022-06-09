//
//  HomeNewTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 03/02/22.
//  Copyright © 2022 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class HomeNewTableViewCell: UITableViewCell {

    @IBOutlet weak var BaseView: UIView!
    
    @IBOutlet weak var TopImg: UIImageView!
    @IBOutlet weak var CheckInLbl: UILabel!
    @IBOutlet weak var CheckOutLbl: UILabel!
    @IBOutlet weak var LocationLbl: UILabel!
    @IBOutlet weak var PropertTypeLbl: UILabel!

    @IBOutlet weak var CheckInBtn: UIButton!
    @IBOutlet weak var CheckOutBtn: UIButton!
    @IBOutlet weak var LocationBtn: UIButton!
    @IBOutlet weak var PropertTypeBtn: UIButton!
    @IBOutlet weak var SearchBtn: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
