//
//  WishlistTVCell.swift
//  HomeStay
//
//  Created by apple on 19/11/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class WishlistTVCell: UITableViewCell {

    @IBOutlet weak var imgHeart: UIImageView!
    @IBOutlet weak var imgProperty: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblPropertyName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var btnWishList: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
