//
//  CategoriesTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 03/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CategoriesLbl: UILabel!
             @IBOutlet weak var BaseView: UIView!
             @IBOutlet weak var CategoriesImg: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
