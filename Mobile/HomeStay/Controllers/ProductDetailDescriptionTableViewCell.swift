//
//  ProductDetailDescriptionTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 27/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ProductDetailDescriptionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
         @IBOutlet weak var DescLbl: UILabel!
        @IBOutlet weak var LaodMoreBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
