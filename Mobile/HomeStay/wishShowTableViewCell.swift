//
//  wishShowTableViewCell.swift
//  HomeStay
//
//  Created by Apple2 on 22/12/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class wishShowTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var wishWish: UIButton!
    @IBOutlet weak var whishPrice: UILabel!
    @IBOutlet weak var wishHost: UIImageView!
    @IBOutlet weak var wishImage: UIImageView!
    @IBOutlet weak var greyBGView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
