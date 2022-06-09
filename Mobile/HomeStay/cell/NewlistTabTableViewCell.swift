//
//  NewlistTabTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 01/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class NewlistTabTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var ProductImg: UIImageView!
    @IBOutlet weak var ProductLoc: UILabel!
    @IBOutlet weak var ProductCost: UILabel!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var ProductRat: UILabel!
    @IBOutlet weak var ProductFav: UIButton!
    @IBOutlet weak var FavImage: UIImageView!
    @IBOutlet weak var SearchImg: UIImageView!
    @IBOutlet weak var StarImg: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
