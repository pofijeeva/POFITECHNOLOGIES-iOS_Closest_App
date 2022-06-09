//
//  ProductDetailBookingTypeTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 28/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ProductDetailBookingTypeTableViewCell: UITableViewCell {

    
     @IBOutlet weak var BaseView: UIView!
     @IBOutlet weak var RequestBtn: UIButton!
     @IBOutlet weak var InstantPayBtn: UIButton!
     @IBOutlet weak var PayBtn: UIButton!
    
    @IBOutlet weak var PayLaterBtn: UIButton!
    @IBOutlet weak var PayLaterView: UIView!
    @IBOutlet weak var PayLaterViewHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
